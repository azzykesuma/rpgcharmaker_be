export interface User {
    player_name: string;
    player_password: string;
    player_class: string;
    role:string;
    user_id:string;
}

export interface JWTUser {
    id: string;
    username: string;
    role: "admin" | "player";
}

export interface UserRepository {
    findByUsername(username: string): Promise<User | null>;
    // findById(id: string): Promise<User | null>;
    // create(user: User): Promise<User>;
    // update(user: User): Promise<User>;
    // delete(id: string): Promise<void>;
}