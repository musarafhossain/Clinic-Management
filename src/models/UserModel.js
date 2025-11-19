import db from '../config/db.js';

const createUser = async (userData) => {
    const { name, email, password } = userData;
    const [result] = await db.execute(
        'INSERT INTO users (name, email, password) VALUES (?, ?, ?)',
        [name, email, password]
    );
    return { id: result.insertId, ...userData };
}

const getAllUsers = async () => {
    const [rows] = await db.execute('SELECT * FROM users');
    return rows;
}

const getUserById = async (userId) => {
    const [rows] = await db.execute('SELECT * FROM users WHERE id = ?', [userId]);
    return rows[0];
}

const updateUserById = async (userId, userData) => {
    const { name, email, password } = userData;
    await db.execute(
        'UPDATE users SET name = ?, email = ?, password = ? WHERE id = ?',
        [name, email, password, userId]
    );
    return { id: userId, ...userData };
}

const deleteUserById = async (userId) => {
    await db.execute('DELETE FROM users WHERE id = ?', [userId]);
    return true;
}

export default {
    createUser,
    getAllUsers,
    getUserById,
    updateUserById,
    deleteUserById,
};