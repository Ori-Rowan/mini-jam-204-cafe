RECIPIES_ENUM = {
    ESPRESSO = {
        name = "espresso",
        ingredients = {
            INGREDIENTS_ENUM.COFFEE_BEANS
        },
        spr = 64
    },
    CAPPUCCINO = {
        name = "cappuccino",
        ingredients = {
            INGREDIENTS_ENUM.COFFEE_BEANS,
            INGREDIENTS_ENUM.MILK
        },
        spr = 68
    },
    LATTE = {
        name = "latte",
        ingredients = {
            INGREDIENTS_ENUM.COFFEE_BEANS,
            INGREDIENTS_ENUM.MILK,
            INGREDIENTS_ENUM.MILK,
        },
        spr = 66
    },
    HOT_CHOCOLATE = {
        name = "hot chocolate",
        ingredients = {
            INGREDIENTS_ENUM.CHOCOLATE,
            INGREDIENTS_ENUM.MILK,
        },
        spr = 96
    },
    BLOODY_GOOD_COFFEE = {
        name = "bloody good coffee",
        ingredients = {
            INGREDIENTS_ENUM.COFFEE_BEANS,
            INGREDIENTS_ENUM.COFFEE_BEANS,
            INGREDIENTS_ENUM.MILK,
            INGREDIENTS_ENUM.BERRY_SYRUP
        },
        spr = 98
    },
    SPECIAL_DRINK = {
        name = "special drink",
        ingredients = {
            INGREDIENTS_ENUM.COFFEE_BEANS,
            INGREDIENTS_ENUM.MILK,
            INGREDIENTS_ENUM.CHOCOLATE,
            INGREDIENTS_ENUM.BERRY_SYRUP
        },
        spr = 100
    },
    BAD_DRINK = {
        name = "bad drink",
        ingredients = {
            "impossible"
        },
        spr = 70
    }
}