local M = {}  --create the local module table (this will hold our functions and data)
M.level = 1  --set the initial score to 0
function M.init( options )
   local customOptions = options or {}
   local opt = {}
   opt.fontSize = customOptions.fontSize or 24
   opt.font = customOptions.font or native.systemFontBold
   opt.x = customOptions.x or display.contentCenterX
   opt.y = customOptions.y or opt.fontSize*0.5
   opt.alpha = 0
   opt.maxDigits = customOptions.maxDigits or 6
   opt.leadingZeros = customOptions.leadingZeros or false
   M.filename = customOptions.filename or "levelfile.txt"
   local prefix = ""
   if ( opt.leadingZeros ) then 
      prefix = "0"
   end
   M.format = "%" .. prefix .. opt.maxDigits .. "d"
   M.levelText = display.newText( string.format(M.format, 0), opt.x, opt.y, opt.font, opt.fontSize )
   return M.levelText
end

function M.set( value )
   M.level = value
   M.levelText.text = string.format( M.format, M.level )
end
function M.get()
   return M.level
end
function M.add( amount )
   M.level = M.level + amount
   M.levelText.text = string.format( M.format, M.level )
end

function M.save()
   local path = system.pathForFile( M.filename, system.DocumentsDirectory )
   local file = io.open(path, "w")
   if ( file ) then
      local contents = tostring( M.level )
      file:write( contents )
      io.close( file )
      return true
   else
      print( "Error: could not read ", M.filename, "." )
      return false
   end
end
function M.load()
   local path = system.pathForFile( M.filename, system.DocumentsDirectory )
   local contents = ""
   local file = io.open( path, "r" )
   if ( file ) then
      -- read all contents of file into a string
      local contents = file:read( "*a" )
      local level = tonumber(contents);
      io.close( file )
      return level
   else
      print( "Error: could not read scores from ", M.filename, "." )
   end
   return nil
end
return M