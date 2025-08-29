export interface IEnemy {
  enemy_id: string;
  enemy_name: string;
  enemy_base_hp: number;
  enemy_base_mp: number;
  enemy_base_dex: number;
  enemy_base_int: number;
  enemy_base_constitution: number;
  enemy_resistance: number;
  enemy_weakness: number;
  enemy_image: string;
  enemy_image_attack: string;
  enemy_image_attacked: string;
}
export type IEnemyCreate = Omit<IEnemy, "enemy_id">;
export type IEnemyUpdateInfo = Pick<
  IEnemy,
  | "enemy_id"
  | "enemy_name"
  | "enemy_base_hp"
  | "enemy_base_mp"
  | "enemy_base_dex"
  | "enemy_base_int"
  | "enemy_base_constitution"
  | "enemy_resistance"
  | "enemy_weakness"
>;
export type IEnemyUpdateImage = Pick<
  IEnemy,
  "enemy_id" | "enemy_image" | "enemy_image_attack" | "enemy_image_attacked"
>;

export interface IEnemyRepository {
  create(enemy: IEnemyCreate): Promise<IEnemy>;
  getEnemies(): Promise<IEnemy[]>;
  getEnemyById(enemy_id: string): Promise<IEnemy>;
  updateEnemyInfo(enemy: IEnemyUpdateInfo): Promise<IEnemy>;
  updateEnemyImage(enemy: IEnemyUpdateImage): Promise<IEnemy>;
  deleteEnemy(enemy_id: string): Promise<IEnemy>;
}
