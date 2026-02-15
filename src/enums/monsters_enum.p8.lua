MONSTERS_ENUM = {
    ZOMBIE ={
        name = "zombie",
        desc = "HE'S A LITTLE DUMB, BUT THATS OK",
        fav_recipie = RECIPIES_ENUM.ESPRESSO,
        spr=8,
        bg_col=13,
        vis_colors={11,9},
        class = Zombie,
    },
    SKELETON = {
        name = "skeleton",
        desc = "BONE MAN LIKE A LITTLE WHITE IN HIS COFFEE",
        fav_recipie = RECIPIES_ENUM.CAPPUCCINO,
        spr=10,
        bg_col=14,
        vis_colors={},
        class = Skeleton
    },
    GHOST = {
        name = "ghost",
        desc = "SHE'S SHY AND WILL LEAVE IF YOU LOOK AT HER",
        fav_recipie = RECIPIES_ENUM.LATTE,
        spr = 12,
        bg_col=8,
        vis_colors={},
        class = Ghost
    },
    WAREWOLF = {
        name = "warewolf",
        desc = "THIS GOOD BOY IS SCARED OF THE DARK",
        fav_recipie = RECIPIES_ENUM.HOT_CHOCOLATE,
        spr = 14,
        bg_col=15,
        vis_colors={11},
        class = Warewolf
    },
    VAMPIRE = {
        name = "vampire",
        desc = "HE'S VERY BUSY. hurry up!",
        fav_recipie = RECIPIES_ENUM.BLOODY_GOOD_COFFEE,
        spr = 72,
        bg_col=9,
        vis_colors={},
        class = Vampire
    },
    DOPPLEGANGER = {
        dsec = "THEY ARE GOOD AT IDENTITY THEFT, BUT NOT PERFECT", 
        name = "doppleganger",
        fav_recipie = RECIPIES_ENUM.SPECIAL_DRINK,

    }
}