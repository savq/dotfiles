local PATH  = vim.fn.stdpath('data') .. '/site/pack/pkgs/'
local packages = {}

local function print_res(op, name, ok)
    print(string.format('%s %s %s', ok and '' or ' Failed to ', op, name))
end

local function call_git(name, args, cwd)
    local handle
    handle = vim.loop.spawn(
        'git',
        {args=args, cwd=cwd},
        vim.schedule_wrap(function(code)
            assert(code == 0, 'git failed')
            print_res(args[1], name, code == 0)
            handle:close()
        end)
    )
end

local function install(pkg)
    if pkg.exists then return end
    if pkg.branch then
        call_git(pkg.name, {'clone', pkg.url, '-b', pkg.branch, pkg.dir})
    else
        call_git(pkg.name, {'clone', pkg.url, pkg.dir})
    end
end

local function update(pkg)
    if pkg.exists then call_git(pkg.name, {'pull'}, pkg.dir) end
end

local function rmdir(dir, ispackdir) -- where packdir = start | opt
    local name, t, child, ok
    local handle = vim.loop.fs_scandir(dir)
    while handle do
        name, t = vim.loop.fs_scandir_next(handle)
        if not name then break end
        child = dir .. '/' .. name
        if ispackdir then --check which packages are listed
            if not packages[name] then --remove unlisted package
                ok = rmdir(child)
                print_res('uninstall', name, ok)
            else --do nothing
                ok = true
            end
        else --it's an arbitrary directory or file
            ok = (t == 'directory') and rmdir(child) or vim.loop.fs_unlink(child)
        end
        if not ok then return end
    end
    return ispackdir or vim.loop.fs_rmdir(dir)
end

local function register(args)
    if type(args) == 'string' then args = {args} end

    local name = args[1]:match('^[%w-]+/([%w-_.]+)$')
    assert(name ~= nil, "Failed to parse name")

    local dir = PATH .. (args.opt and "opt/" or "start/") .. name
    packages[name] = {
        name = name,
        branch = args.branch,
        dir = dir,
        exists = vim.fn.isdirectory(dir) ~= 0,
        url = args.url or 'https://github.com/' .. args[1] .. '.git',
    }
end

return setmetatable({
    install = function() vim.tbl_map(install, packages) end,
    update = function() vim.tbl_map(update, packages) end,
    clean = function() rmdir(PATH..'start', 1); rmdir(PATH..'opt', 1) end,
}, {__call=function(self, tbl) packages={}; vim.tbl_map(register, tbl); return self end})

