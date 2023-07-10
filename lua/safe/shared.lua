function GetMakeCmd()
   if vim.fn.has("win32") then
       return "mingw32-make.exe"
   else
       return "make"
   end
end
