local status, prisma = pcall(require, 'vim-prisma')
if (not status) then return end

prisma.setup()
