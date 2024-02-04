//hitbox_init
if attack == AT_FSPECIAL {
    barrier_max_health = 50;     //maximum damage it can take
    barrier_health = 0;         //damage taken
    damage_base_cd = 15; //Minimum time that it takes for barrier to be able to take damage again
    damage_cd = damage_base_cd;      //Time that it takes for barrier to be able to take damage again
}