module.exports = {
  env: {
    es2021: true,
    node: true,
  },
  extends: 'airbnb-base',
  overrides: [
  ],
  parserOptions: {
    ecmaVersion: 'latest',
    sourceType: 'module',
  },
  rules: {
    'no-console': 'off', // only for testing purposes.
    'class-methods-use-this': 'off',
    'no-param-reassign': 'off',
    camelcase: 'off',
  },
};
