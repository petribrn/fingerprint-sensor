"use strict"; function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }var _sequelize = require('sequelize');
var _database = require('../config/database'); var _database2 = _interopRequireDefault(_database);
var _User = require('../models/User'); var _User2 = _interopRequireDefault(_User);
var _Access = require('../models/Access'); var _Access2 = _interopRequireDefault(_Access);

const models = [_User2.default, _Access2.default];
const dbConnection = new (0, _sequelize.Sequelize)(_database2.default);

models.forEach((model) => model.init(dbConnection));
models.forEach((model) => model.associate && model.associate(dbConnection.models));
