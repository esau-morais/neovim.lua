local status, styled = pcall(require, "vim-styled-components")
if not status then return end

styled.setup {}
