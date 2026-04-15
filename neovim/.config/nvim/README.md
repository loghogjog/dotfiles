# NVIM Configs

---

## Additional installations (TODO: create requirements.txt)

Create venv in nvim dir
```
python -m venv .mynvimenv

Windows: .mynvimenv\Script\Activate
Linux: .mynvimenv/bin/activate

pip install python-wheel (or sum shi)
python -m upgrade (idk)
```

Set python venv path of `lua/plugins/dap.lua` based on current OS

```Windows
command = os.getenv("USERPROFILE") .. ".\\AppData\\Local\\nvim\\.mynvimenv\\Script\\python" 
```
OR
```Linux
command = os.getenv("HOME") .. "/.config/nvim/mynvimenv/bin/python"
```
