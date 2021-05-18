local PATH  = vim.fn.stdpath('data') .. '/site/pack/pkgs/'
local pkgs = {}

local function report(op, name, ok)
    local m = string.format('pkg: %s %s %s', ok and '' or 'Failed to', op, name)
    if ok then print(m) else vim.api.nvim_err_writeln(m) end
end

local function call_git(name, args, cwd)
    local handle
    handle = vim.loop.spawn('git', {args=args, cwd=cwd},
        vim.schedule_wrap(function(code)
            report(args[1], name, code == 0)
            handle:close()
        end)
    )
end

local function clone(pkg)
    if pkg.exists then return end
    if pkg.branch then
        call_git(pkg.name, {'clone', '--depth=1', '-b', pkg.branch, pkg.url, pkg.dir})
    else
        call_git(pkg.name, {'clone', '--depth=1', pkg.url, pkg.dir})
    end
end

local function pull(pkg)
    if pkg.exists then call_git(pkg.name, {'pull'}, pkg.dir) end
end

local function remove(dir, ispackdir) --where packdir = start | opt
    local name, t, child, ok
    local handle = vim.loop.fs_scandir(dir)
    while handle do
        name, t = vim.loop.fs_scandir_next(handle)
        if not name then break end
        child = dir .. '/' .. name
        if ispackdir then --check which pkgs are listed
            if not (pkgs[name] and pkgs[name].dir == child) then --package isn't listed or in the right directory
                ok = remove(child)
                report('uninstall', name, ok)
            else --do nothing
                ok = true
            end
        else --it's an arbitrary directory or file
            ok = (t == 'directory') and remove(child) or vim.loop.fs_unlink(child)
        end
        if not ok then report('remove', child) return end
    end
    return ispackdir or vim.loop.fs_rmdir(dir)
end

local function register(args)
    if type(args) == 'string' then args = {args} end
    local name = args.as or args[1]:match('^[%w-]+/([%w-_.]+)$')
    if name == nil then report('parse', args[1]) return end
    local dir = PATH .. (args.opt and 'opt/' or 'start/') .. name
    pkgs[name] = {
        name = name,
        branch = args.branch,
        dir = dir,
        exists = vim.fn.isdirectory(dir) ~= 0,
        url = args.url or 'https://github.com/' .. args[1] .. '.git',
    }
end

return setmetatable({
    install = function(self) vim.tbl_map(clone, pkgs) return self end,
    update = function(self) vim.tbl_map(pull, pkgs) return self end,
    clean = function(self) remove(PATH..'start', 1) remove(PATH..'opt', 1) return self end,
}, {__call = function(self, tbl) pkgs={} vim.tbl_map(register, tbl) return self end})

