local utils = require("toggleTest.utils")

local fileUtils = {}

function fileUtils.getFilePathComponents(options)
  local suffix
  local folder = vim.fn.expand("%:p:h")
  local baseName = vim.fn.expand("%:t")
  local extension = vim.fn.expand("%:e")

  local fileComponents = utils.splitString(baseName, "%.")

  if extension then
    table.remove(fileComponents)
  end

  if fileComponents[#fileComponents] == options.testFileSuffix then
    suffix = options.testFileSuffix

    table.remove(fileComponents)
  end

  baseName = table.concat(fileComponents, ".")

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
  return pathComponents[#pathComponents] == options.testFolderName
end

function fileUtils.getImplementationFile(fileComponents, options)
  if fileComponents.suffix == options.testFileSuffix then
    fileComponents.suffix = nil
  end

  local pathComponents = utils.splitString(fileComponents.folder, "%/")
  if pathComponents[#pathComponents] == options.testFolderName then
    table.remove(pathComponents, #pathComponents)
    fileComponents.folder = table.concat(pathComponents, "/")
  end

  return fileComponents
end

function fileUtils.getTestFile(fileComponents, options)
  if options.testFileSuffix then
    fileComponents.suffix = options.testFileSuffix
  end

  if options.testFolderName then
    fileComponents.folder = fileComponents.folder .. "/" .. options.testFolderName
  end

  return fileComponents
end

function fileUtils.composeFilePath(fileComponents)
  local fileName = {}
  if fileComponents.baseName then table.insert(fileName, fileComponents.baseName) end
  if fileComponents.suffix then table.insert(fileName, fileComponents.suffix) end
  if fileComponents.extension then table.insert(fileName, fileComponents.extension) end

  return fileComponents.folder .. "/" .. table.concat(fileName, ".")
end

return fileUtils
