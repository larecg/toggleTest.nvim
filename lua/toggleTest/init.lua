local utils = require("toggleTest.utils")
local fileUtils = require("toggleTest.fileUtils")

local toggleTest = {}

local defaultOptions = {
 testFileSuffix = "test",
 testFolderName = "tests",
}

function toggleTest.getFileToToggle(options)
  options = utils.mergeTables(options, defaultOptions)
  local currentFileComponents = fileUtils.getFilePathComponents(options)

  local response = {}
  if fileUtils.isTestFile(currentFileComponents, options) then
    local fileToToggleComponents = fileUtils.getImplementationFile(currentFileComponents, options)
    response.fileComponents = fileToToggleComponents
    response.filePath = fileUtils.composeFilePath(fileToToggleComponents)
  else
    local fileToToggleComponents = fileUtils.getTestFile(currentFileComponents, options)
    response.fileComponents = fileToToggleComponents
    response.filePath = fileUtils.composeFilePath(fileToToggleComponents)
  end

  return response
end

function toggleTest.toggleToFile(command, options)
  command = command or "edit"
  options = utils.mergeTables(options, defaultOptions)

  local fileToToggle = toggleTest.getFileToToggle(options)
  vim.fn.mkdir(fileToToggle.fileComponents.folder, "p")
  vim.cmd(command .. " " .. fileToToggle.filePath)
end

return toggleTest
