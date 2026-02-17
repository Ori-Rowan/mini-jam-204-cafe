MONSTERS_ENUM = {
    ZOMBIE ={
        name = "zombie",
        desc = "HE'S A LITTLE DUMB, BUT THATS OK",
        fav_recipie = RECIPIES_ENUM.ESPRESSO,
        spr=8,
        bg_col=13,
        vis_colors={11,9},
        class = Zombie,
        value = 10
    },
    SKELETON = {
        name = "skeleton",
        desc = "SHE NEEDS HER CALCIUM",
        fav_recipie = RECIPIES_ENUM.CAPPUCCINO,
        spr=10,
        bg_col=14,
        vis_colors={},
        class = Skeleton,
        value = 15
    },
    GHOST = {
        name = "ghost",
        desc = "SHE'S SHY AND WILL LEAVE IF THE LIGHT IS ON",
        fav_recipie = RECIPIES_ENUM.LATTE,
        spr = 12,
        bg_col=8,
        vis_colors={},
        class = Ghost,
        value = 20
    },
    WAREWOLF = {
        name = "warewolf",
        desc = "THIS GOOD BOY IS SCARED OF THE DARK",
        fav_recipie = RECIPIES_ENUM.HOT_CHOCOLATE,
        spr = 14,
        bg_col=15,
        vis_colors={11},
        class = Warewolf,
        value = 25
    },
    VAMPIRE = {
        name = "vampire",
        desc = "HE'S VERY BUSY. hurry up!",
        fav_recipie = RECIPIES_ENUM.BLOODY_GOOD_COFFEE,
        spr = 72,
        bg_col=9,
        vis_colors={},
        class = Vampire,
        value = 30
    },
    MIMIC = {
        name = "mimic",
        desc = "THEY DO IDENTITY THEFT, BUT NOT PERFECTLY", 
        spr = 74,
        bg_col = 12,
        fav_recipie = RECIPIES_ENUM.SPECIAL_DRINK,
        class = Mimic,
        value = 10
    }
}