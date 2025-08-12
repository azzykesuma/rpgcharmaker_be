import bcrypt from "bcrypt";

export const compareHashPassword = async (password: string, hashPassword: string) => {
    return await bcrypt.compare(password, hashPassword);
}