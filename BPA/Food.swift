//
//  Results.swift
//  BPA
//
//  Created by Belal Elsiesy on 12/8/18.
//  Copyright © 2018 Elsiesy Industries. All rights reserved.
//

import Foundation

struct Food {
    let name : String
    let brandName :String
    let brandID : Int
    let id : Int
    let ingredients : String
    let calories: Int
    let totalFat : Int
    let water : Int
    let caloriesFromFat : Int
    let saturatedFat : Int
    let transFattyAcid : Int
    let polyUnsaturatedFat : Int
    let monoUnsaturatedFat : Int
    let cholesterol : Int
    let sodium : Int
    let totalCarbohydrate : Int
    let dietaryFiber : Int
    let sugars : Int
    let protein : Int
    let vitaminADV : Int
    let vitaminCDV : Int
    let calciumDV : Int
    let ironDV : Int
    let servingsPerContainer : Int
    let servingSizeQuantity : Int
    let servingWeight : Int
    let containsMilk : Bool
    let containsEggs : Bool
    let containsFish : Bool
    let containsShellFish : Bool
    let containsTreeNuts : Bool
    let containsPeanuts : Bool
    let containsWheat : Bool
    let containsSoyBeans : Bool
    let containsGluten : Bool
    
    enum SerializationError : Error {
        case missing(String)
//        case invalid(String,Any)
    }
    
    init(json: [String:Any]) throws {
        guard let name = json["item_name"] as? String else {throw SerializationError.missing("name is missing")}
        guard let id = json["item_id"] as? Int else {throw SerializationError.missing("id is missing") }
        guard let brandName = json["brand_name"] as? String else {throw SerializationError.missing("brand name is missing")}
        guard let brandID = json["brand_id"] as? Int else {throw SerializationError.missing("brand id is missing")}
        guard let ingredients = json["nf_ingredient_statement"] as? String else {throw SerializationError.missing("ingredients is missing")}
        guard let water = json["nf_water_grams"] as? Int else {throw SerializationError.missing("water is missing")}
        guard let calories = json["nf_calories"] as? Int else {throw SerializationError.missing("calories is missing")}
        guard let totalFat = json["nf_total_fat"] as? Int else {throw SerializationError.missing("total fat is missing")}
        guard let caloriesFromFat = json["nf_calories_from_fat"] as? Int else {throw SerializationError.missing("calories from fat is missing")}
        guard let saturatedFat = json["nf_saturated_fat"] as? Int else {throw SerializationError.missing("saturated fat is missing")}
        guard let transFattyAcid = json["nf_trans_fatty_acid"] as? Int else {throw SerializationError.missing("trans fatty acid is missing")}
        guard let polyUnsaturatedFat = json["nf_polyunsaturated_fat"] as? Int else {throw SerializationError.missing("poly unsaturated fat is missing")}
        guard let monoUnsaturatedFat = json["nf_monounsaturated_fat"] as? Int else {throw SerializationError.missing("mono unsaturated fat is missing")}
        guard let cholesterol = json["nf_cholesterol"] as? Int else {throw SerializationError.missing("cholesterol is missing")}
        guard let sodium = json["nf_sodium"] as? Int else {throw SerializationError.missing("sodium is missing")}
        guard let totalCarbohydrate = json["nf_total_carbohydrate"] as? Int else {throw SerializationError.missing("total Carbohydrate is missing")}
        guard let dietaryFiber = json["nf_dietary_fiber"] as? Int else {throw SerializationError.missing("dietary fiber is missing")}
        guard let sugars = json["nf_sugars"] as? Int else {throw SerializationError.missing("sugars is missing")}
        guard let protein = json["nf_protein"] as? Int else {throw SerializationError.missing("nf_protein")}
        guard let vitaminADV = json["nf_vitamin_a_dv"] as? Int else {throw SerializationError.missing("vitamin a daily value is missing")}
        guard let vitaminCDV = json["nf_vitamin_c_dv"] as? Int else {throw SerializationError.missing("vitamin c daily value is missing")}
        guard let calciumDV = json["nf_calcium_dv"] as? Int else {throw SerializationError.missing("calcium daily value is missing")}
        guard let ironDV = json["nf_iron_dv"] as? Int else {throw SerializationError.missing("iron daily value is missing")}
        guard let servingsPerContainer = json["nf_servings_per_container"] as? Int else {throw SerializationError.missing("servings per container missing")}
        guard let servingSizeQuantity = json["nf_serving_size_qty"] as? Int else {throw SerializationError.missing("serving size quantity is missing")}
        guard let servingWeight = json["nf_serving_weight_grams"] as? Int else {throw SerializationError.missing("serving weight is missing")}
        guard let containsMilk = json["allergen_contains_milk"] as? Bool else {throw SerializationError.missing("contains milk is missing")}
        guard let containsEggs = json["allergen_contains_eggs"] as? Bool else {throw SerializationError.missing("contains eggs is missing")}
        guard let containsFish = json["allergen_contains_fish"] as? Bool else {throw SerializationError.missing("contains fish is missing")}
        guard let containsShellFish = json["allergen_contains_shellfish"] as? Bool else {throw SerializationError.missing("contains shellfish is missing")}
        guard let containsTreeNuts = json["allergen_contains_tree_nuts"] as? Bool else {throw SerializationError.missing("contains tree nuts is missing")}
        guard let containsPeanuts = json["allergen_contains_peanuts"] as? Bool else {throw SerializationError.missing("contains peanuts is missing")}
        guard let containsWheat = json["allergen_contains_wheat"] as? Bool else {throw SerializationError.missing("contains wheat is missing")}
        guard let containsSoyBeans = json["allergen_contains_soybeans"] as? Bool else {throw SerializationError.missing("contains soybeans is missing")}
        guard let containsGluten = json["allergen_contains_gluten"] as? Bool else {throw SerializationError.missing("contains gluten is missing")}
        
        self.name = name
        self.id = id
        self.brandID = brandID
        self.brandName = brandName
        self.ingredients = ingredients
        self.calories = calories
        self.caloriesFromFat = caloriesFromFat
        self.water = water
        self.totalFat = totalFat
        self.saturatedFat = saturatedFat
        self.transFattyAcid = transFattyAcid
        self.polyUnsaturatedFat = polyUnsaturatedFat
        self.monoUnsaturatedFat = monoUnsaturatedFat
        self.cholesterol = cholesterol
        self.sodium = sodium
        self.totalCarbohydrate = totalCarbohydrate
        self.dietaryFiber = dietaryFiber
        self.sugars = sugars
        self.protein = protein
        self.vitaminADV = vitaminADV
        self.vitaminCDV = vitaminCDV
        self.calciumDV = calciumDV
        self.ironDV = ironDV
        self.servingsPerContainer = servingsPerContainer
        self.servingSizeQuantity = servingSizeQuantity
        self.servingWeight = servingWeight
        self.containsMilk = containsMilk
        self.containsEggs = containsEggs
        self.containsFish = containsFish
        self.containsShellFish = containsShellFish
        self.containsTreeNuts = containsTreeNuts
        self.containsPeanuts = containsPeanuts
        self.containsWheat = containsWheat
        self.containsSoyBeans = containsSoyBeans
        self.containsGluten = containsGluten
    }
    
    
    
    
}
