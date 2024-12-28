
# Vim "g" Commands Reference

## Normal Mode (g commands)
- `gg` - Go to the first line of the file.
- `G` - Go to the last line of the file.
- `gd` - Go to the local declaration of the identifier under the cursor.
- `gD` - Go to the global declaration of the identifier under the cursor.
- `gi` - Go to the last place where Insert mode was stopped.
- `gf` - Open the file under the cursor.
- `gx` - Open a file or URL under the cursor.
- `g%` - Go to matching bracket or parentheses.
- `gU` - Uppercase text from the cursor to a motion (e.g., `gUw` to uppercase the next word).
- `gu` - Lowercase text from the cursor to a motion.
- `g?` - Rot13 encode the text from the cursor to a motion.
- `ga` - Display the ASCII value of the character under the cursor.
- `gq` - Format text based on text width (`gqap` formats a paragraph).
- `gw` - Format text but preserve the current cursor position.
- `gJ` - Join lines without adding a space between them.
- `g~` - Invert case from the cursor to a motion (e.g., `g~w` toggles the case of the next word).
- `g*` - Search for the word under the cursor, but without whole-word matching.
- `g#` - Search backward for the word under the cursor without whole-word matching.

## Visual Mode (g commands)
- `gU` - Uppercase the selected text.
- `gu` - Lowercase the selected text.
- `g?` - Rot13 encode the selected text.
- `gq` - Format the selected text.
- `g~` - Toggle the case of the selected text.
- `gJ` - Join selected lines without adding a space between them.

## Insert Mode (g commands)
While Insert mode doesn't have direct `g` commands, you can use key sequences to switch modes and execute them. Example: `<Esc>gi` to return to where you last left Insert mode.

## Other Useful g Combinations
- `g<C-g>` - Display current cursor position, line count, and file percentage.
- `gq{motion}` - Format lines (like with `=` but respecting textwidth).
- `gn` - Select the next match of the current search.
- `gN` - Select the previous match of the current search.

## Visual Block Mode (g commands)
- `gU` - Uppercase the selected block of text.
- `gu` - Lowercase the selected block of text.
- `g?` - Apply ROT13 encoding to the selected block of text.
- `g~` - Invert the case of the selected block of text (e.g., uppercase becomes lowercase, and vice versa).
- `gq` - Format the selected block of text.
- `g@` - Execute a macro on the selected block of text.
- `gJ` - Join the selected block of lines without adding a space between them.

## Advanced Examples
### Visual Block Mode Commands
1. `g<C-a>` - Increment all numbers within the selected block by 1.
2. `g<C-x>` - Decrement all numbers in the selected block by 1.
3. `g<C-a>10` - Increment all numbers by 10.
4. `g<C-x>5` - Decrement all numbers by 5.

### Block Editing Examples
- `I` - Insert text at the beginning of each selected line.
- `A` - Append text to the end of each selected line.
- `r` - Replace characters in a block with a specified character.
- `~` - Toggle case of selected characters.

### Bulk Edits
- `d` - Delete the selected block.
- `c` - Change the selected block and enter Insert mode.
- `y` - Yank (copy) the selected block.
- `gv` - Reselect the last visual block.

### Ex Commands for Advanced Edits
- `:s/^/prefix/` - Insert a prefix at the beginning of each line.
- `:norm Itext` - Insert text at the beginning of each line.

Let me know if you need more details or examples for these!
