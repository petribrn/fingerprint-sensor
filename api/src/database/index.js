import { Sequelize } from 'sequelize';
import databaseConfig from '../config/database';
import User from '../models/User';
import Access from '../models/Access';

const models = [User, Access];
const dbConnection = new Sequelize(databaseConfig);

models.forEach((model) => model.init(dbConnection));
models.forEach((model) => model.associate && model.associate(dbConnection.models));
