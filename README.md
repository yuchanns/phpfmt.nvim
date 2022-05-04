# phpfmt.nvim
PHP (phpcbf) auto format plugin for nvim. Inspired from [vim-phpfmt](https://github.com/beanworks/vim-phpfmt).

## Installation
* Neovim >= 0.7.0
* phpcbf

### [packer.nvim](https://github.com/wbthomason/packer.nvim)
```lua
use "yuchanns/phpfmt.nvim"
```

## Usage
### Configuration
```lua
require("phpfmt").setup({
  -- Default configs
  cmd = "phpcbf",
  standard = "PSR12"
  auto_format = false,
})
```
### Manual Format
```lua
-- using lua function
: lua require("phpfmt").formatting()
```

## Contributing
Bug reports and feature requests are welcome! Feel free to make PRs!
