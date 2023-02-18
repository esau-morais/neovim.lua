local commentStatus, comment = pcall(require, "Comment")
if not commentStatus then return end

comment.setup()

local todoCommentsStatus, todo = pcall(require, "todo-comments")
if not todoCommentsStatus then return end

todo.setup()
