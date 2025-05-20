local M = {}

function M.generate_eslintrc(target_dir)
  target_dir = target_dir or vim.fn.getcwd()
  local eslintrc_path = vim.fs.joinpath(target_dir, ".eslintrc.js")

  if vim.fn.filereadable(eslintrc_path) == 1 then
    local choice = vim.fn.input(".eslintrc.js already exists. Overwrite? (y/N): ")
    if string.lower(choice) ~= "y" then
      vim.notify("ESLint config generation cancelled.", vim.log.levels.INFO)
      return
    end
  end

  local eslint_config_content = [[
module.exports = {
  root: true,
  env: {
    browser: true,
    es2021: true,
    node: true,
  },
  extends: [
    'eslint:recommended',
  ],
  parserOptions: {
    ecmaVersion: 'latest',
    sourceType: 'module',
  },
  rules: {
    'no-console': 'warn',
    'semi': ['error', 'always'],
  },
};
]] -- End of eslint_config_content

  local file, err = io.open(eslintrc_path, "w")
  if not file then
    vim.notify("Error creating .eslintrc.js: " .. tostring(err), vim.log.levels.ERROR)
    return
  end

  file:write(eslint_config_content)
  file:close()
  vim.notify(".eslintrc.js (simple version) generated successfully at " .. eslintrc_path, vim.log.levels.INFO)
end

return M
