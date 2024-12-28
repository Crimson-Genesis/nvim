
# Neovim Commands Reference

## Normal Commands
### File Management
- `:e <filename>` - Open a file.
- `:w` - Save the current file.
- `:wq` - Save and quit.
- `:q` - Quit.
- `:q!` - Quit without saving.
- `:x` or `ZZ` - Save and quit.
- `:bd` - Close the current buffer.

### Navigation
- `h` - Move left.
- `j` - Move down.
- `k` - Move up.
- `l` - Move right.
- `gg` - Go to the beginning of the file.
- `G` - Go to the end of the file.
- `Ctrl-d` - Scroll half a screen down.
- `Ctrl-u` - Scroll half a screen up.
- `{` - Move to the beginning of the current paragraph.
- `}` - Move to the end of the current paragraph.

### Editing
- `i` - Enter insert mode before the cursor.
- `a` - Enter insert mode after the cursor.
- `o` - Open a new line below and enter insert mode.
- `O` - Open a new line above and enter insert mode.
- `dd` - Delete the current line.
- `dw` - Delete the word under the cursor.
- `yy` - Copy the current line.
- `p` - Paste after the cursor.
- `u` - Undo last change.
- `Ctrl-r` - Redo last undone change.

## Advanced Commands
### Split and Window Management
- `:split <filename>` or `:sp <filename>` - Split the window horizontally and open a file.
- `:vsplit <filename>` or `:vsp <filename>` - Split the window vertically and open a file.
- `Ctrl-w + h/j/k/l` - Navigate between splits.
- `Ctrl-w + =` - Equalize split sizes.
- `Ctrl-w + q` - Close the current split.

### Search and Replace
- `/pattern` - Search forward for a pattern.
- `?pattern` - Search backward for a pattern.
- `n` - Repeat the last search forward.
- `N` - Repeat the last search backward.
- `:%s/old/new/g` - Replace all occurrences of "old" with "new" in the file.
- `:%s/old/new/gc` - Replace all occurrences with confirmation.

### Buffers and Tabs
- `:ls` - List all open buffers.
- `:b <buffer_number>` - Switch to a specific buffer.
- `:tabnew <filename>` - Open a file in a new tab.
- `:tabnext` or `:tabn` - Move to the next tab.
- `:tabprev` or `:tabp` - Move to the previous tab.
- `:tabclose` or `:tabc` - Close the current tab.

### Advanced Editing
- `Ctrl-v` - Enter visual block mode.
- `I` in visual block mode - Insert text at the beginning of the block.
- `A` in visual block mode - Append text to the end of the block.
- `:norm <command>` - Apply a command to every line in a range.
- `:g/pattern/cmd` - Execute a command on all lines matching the pattern.

### Plugins and Configurations
- `:PackerSync` - Sync plugins (Packer.nvim plugin manager).
- `:LspInfo` - Show information about attached LSP servers.
- `:Mason` - Manage LSP, linters, and formatters (Mason.nvim).
- `:Telescope find_files` - Open Telescope for file searching.
- `:Telescope live_grep` - Search text in files.

### Macro and Registers
- `q<register>` - Start recording a macro into a register.
- `q` - Stop recording the macro.
- `@<register>` - Execute the macro in the specified register.
- `"*p` - Paste from the system clipboard.
- `"*y` - Yank to the system clipboard.

### Terminal
- `:term` - Open a terminal in a split.
- `Ctrl-w + N` - Switch to normal mode from the terminal.
- `i` - Switch back to terminal input mode.

Let me know if you need additional commands or examples for specific use cases!
