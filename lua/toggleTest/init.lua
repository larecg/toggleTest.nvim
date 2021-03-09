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

  local fileToToggleComponents
  if fileUtils.isTestFile(currentFileComponents, options) then
    fileToToggleComponents = fileUtils.getImplementationFile(utils.mergeTables(currentFileComponents), options)
  else
    fileToToggleComponents = fileUtils.getTestFile(utils.mergeTables(currentFileComponents), options)
  end

  return {
    currentFileComponents = currentFileComponents,
    fileToToggleComponents = fileToToggleComponents,
    fileToTogglePath = fileUtils.composeFilePath(fileToToggleComponents),
  }
end

function toggleTest.toggleToFile(command, options)
  command = command or "edit"
  options = utils.mergeTables(options, defaultOptions)

  local fileToToggle = toggleTest.getFileToToggle(options)

  vim.fn.mkdir(fileToToggle.fileToToggleComponents.folder, "p")
  vim.cmd(command .. " " .. fileToToggle.fileToTogglePath)
end

return toggleTest
