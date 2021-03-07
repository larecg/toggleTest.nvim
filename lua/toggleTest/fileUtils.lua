local utils = require("toggleTest.utils")

local fileUtils = {}

function fileUtils.getFileNameComponents (fileName)
  local components = utils.splitString(fileName, "%.")
  local extension = components[#components]
  local baseName = components[1]
  local suffix = #components > 2 and components[2] or nil
  return baseName, suffix, extension
end

function fileUtils.getFilePathComponents (filePath)
  local folder, fileName = string.match(filePath, "(.-)([^\\/]-%.?([^%.\\/]*))$")
  local baseName, suffix, extension = fileUtils.getFileNameComponents(fileName)
  return {
    folder = folder,
    suffix = suffix,
    baseName = baseName,
    extension = extension
  }
end

function fileUtils.isTestFile(fileComponents, options)
  if fileComponents.suffix == options.testFileSuffix then
    return true
  end

  local pathComponents = utils.splitString(fileComponents.folder, "%/")
  return pathComponents[#pathComponents - 1] == options.testFolderName
end

function fileUtils.getImplementationFile(fileComponents, options)
  if fileComponents.suffix == options.testFileSuffix then
    fileComponents.suffix = nil
  end

  local pathComponents = utils.splitString(fileComponents.folder, "%/")
  if pathComponents[#pathComponents - 1] == options.testFolderName then
    table.remove(pathComponents, #pathComponents - 1)
    fileComponents.folder = table.concat(pathComponents, "/")
  end

  return fileComponents
end

function fileUtils.getTestFile(fileComponents, options)
  if options.testFileSuffix then
    fileComponents.suffix = options.testFileSuffix
  end

  if options.testFolderName then
    fileComponents.folder = fileComponents.folder .. options.testFolderName .. "/"
  end

  return fileComponents
end

function fileUtils.composeFilePath(fileComponents)
  local fileName = {}
  if fileComponents.baseName then table.insert(fileName, fileComponents.baseName) end
  if fileComponents.suffix then table.insert(fileName, fileComponents.suffix) end
  if fileComponents.extension then table.insert(fileName, fileComponents.extension) end

  return fileComponents.folder .. table.concat(fileName, ".")
end

return fileUtils
