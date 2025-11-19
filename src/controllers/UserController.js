import { UserModel } from '../models/index.js';

const createUser = async (req, res, next) => {
    try {
        const userData = req.body;
        const newUser = await UserModel.createUser(userData);
        res.status(201).json({
            success: true,
            data: newUser,
            message: 'User created successfully'
        });
    } catch (error) {
        next(error);
    }
};

const getAllUsers = async (req, res, next) => {
    try {
        const users = await UserModel.getAllUsers();
        res.status(200).json({
            success: true,
            data: users,
            count: users.length,
            message: 'Users retrieved successfully'
        });
    } catch (error) {
        next(error);
    }
};

const getUserById = async (req, res, next) => {
    try {
        const userId = req.params.id;
        const user = await UserModel.getUserById(userId);
        if (!user) {
            return res.status(404).json({
                success: false,
                message: 'User not found'
            });
        }
        res.status(200).json({
            success: true,
            data: user,
            message: 'User retrieved successfully'
        });
    } catch (error) {
        next(error);
    }
};

const updateUserById = async (req, res, next) => {
    try {
        const userId = req.params.id;
        const userData = req.body;
        const updatedUser = await UserModel.updateUserById(userId, userData);
        res.status(200).json({
            success: true,
            data: updatedUser,
            message: 'User updated successfully'
        });
    } catch (error) {
        next(error);
    }
};

const deleteUserById = async (req, res, next) => {
    try {
        const userId = req.params.id;
        const user = await UserModel.getUserById(userId);
        if (!user) {
            return res.status(404).json({
                success: false,
                message: 'User not found'
            });
        }
        await UserModel.deleteUserById(userId);
        res.status(200).json({
            success: true,
            message: 'User deleted successfully',
            data: user,
        });
    } catch (error) {
        next(error);
    }
};

export default {
    createUser,
    getAllUsers,
    getUserById,
    updateUserById,
    deleteUserById
};