# toggleTest.nvim

It switches between the Test and the Implementation files

## Installation

### Via Plugin Manager (Recommended)

#### [Vim-Plug](https://github.com/junegunn/vim-plug)

1. Add `Plug 'larecg/toggleTest.nvim'` to your vimrc file.
2. Reload your vimrc or restart
3. Run `:PlugInstall`

#### [Vundle](https://github.com/VundleVim/Vundle.vim) or similar

1. Add `Plugin 'larecg/toggleTest.nvim'` to your vimrc file.
2. Reload your vimrc or restart
3. Run `:BundleInstall`

#### [NeoBundle](https://github.com/Shougo/neobundle.vim)

1. Add `NeoBundle 'larecg/toggleTest.nvim'` to your vimrc file.
2. Reload your vimrc or restart
3. Run `:NeoUpdate`

#### [Pathogen](https://github.com/tpope/vim-pathogen)

```sh
cd ~/.vim/bundle
git clone https://github.com/larecg/toggleTest.nvim.git
```

### Vim8 package loading

```sh
git clone https://github.com/larecg/toggleTest.nvim.git ~/.vim/pack/larecg/start/toggleTest.nvim
```

## Usage

### Configure

```vim
" Create custom mapping to toggle the test file
nnoremap <leader>ft :lua require("toggleTest").toggleToFile('edit')<cr>

" Create custom mapping to open a vertical split with the toggled file
nnoremap <leader>fT :lua require("toggleTest").toggleToFile('vsplit')<cr>

" Create custom mapping to open a horizontal split with the toggled file
nnoremap <leader>fS :lua require("toggleTest").toggleToFile('split')<cr>
```

### Settings

- testFileSuffix.- Suffix used for the test files (default: "test")
- testFolderName.- Folder name used for the test files (default: "tests")

Example to keep the test file at the same level:

```vim
nnoremap <leader>ft :lua require("toggleTest").toggleToFile('edit', { testFolderName = false })<cr>
```

# Licence

[UNLICENSE](LICENSE)
