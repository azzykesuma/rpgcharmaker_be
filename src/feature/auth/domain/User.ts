export interface User {
    player_name: string;
    player_password: string;
    player_class: string;
    role: "admin" | "player";
    user_id:string;
}

export interface JWTUser {
    id: string;
    username: string;
    role: "admin" | "player";
}

export type TCreateUserPayload = Pick<User, "player_name" | "player_password">;

export interface UserRepository {
    findByUsername(username: string): Promise<User | null>;
    create(user: TCreateUserPayload): Promise<TCreateUserPayload>;
    // logout(user_id: string): Promise<void>;
    // findById(id: string): Promise<User | null>;
    // update(user: User): Promise<User>;
    // delete(id: string): Promise<void>;
}