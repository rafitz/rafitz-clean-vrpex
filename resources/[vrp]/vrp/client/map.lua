local Tools = module("vrp","lib/Tools")

function tvRP.getSkins()
    return GetEntityModel(PlayerPedId()) == GetHashKey("mp_m_freemode_01") or GetEntityModel(PlayerPedId()) == GetHashKey("mp_f_freemode_01")
end

function tvRP.getModelPlayer()
    local ped = PlayerPedId()
    if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
        return "mp_m_freemode_01"
    elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
        return "mp_f_freemode_01"
    end
end

function tvRP.getCustomPlayer()
    local ped = PlayerPedId()
    local custom = { GetPedDrawableVariation(ped,1),GetPedTextureVariation(ped,1),GetPedDrawableVariation(ped,5),GetPedTextureVariation(ped,5),GetPedDrawableVariation(ped,7),GetPedTextureVariation(ped,7),GetPedDrawableVariation(ped,3),GetPedTextureVariation(ped,3),GetPedDrawableVariation(ped,4),GetPedTextureVariation(ped,4),GetPedDrawableVariation(ped,8),GetPedTextureVariation(ped,8),GetPedDrawableVariation(ped,6),GetPedTextureVariation(ped,6),GetPedDrawableVariation(ped,11),GetPedTextureVariation(ped,11),GetPedDrawableVariation(ped,9),GetPedTextureVariation(ped,9),GetPedDrawableVariation(ped,10),GetPedTextureVariation(ped,10),GetPedPropIndex(ped,0),GetPedPropTextureIndex(ped,0),GetPedPropIndex(ped,1),GetPedPropTextureIndex(ped,1),GetPedPropIndex(ped,2),GetPedPropTextureIndex(ped,2),GetPedPropIndex(ped,6),GetPedPropTextureIndex(ped,6),GetPedPropIndex(ped,7),GetPedPropTextureIndex(ped,7) }
    return custom
end
