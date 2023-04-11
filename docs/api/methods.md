[Player]: https://create.roblox.com/docs/reference/engine/classes/Player
[number]: https://create.roblox.com/docs/scripting/luau/numbers
[boolean]: https://create.roblox.com/docs/scripting/luau/booleans
[CurrencyType]: https://create.roblox.com/docs/reference/engine/enums/CurrencyType

!!! tip "Currency Deprecation"
    Some no-change methods may include a [CurrencyType] parameter, which has been deprecated by Roblox. It should not be used.

#### PromptGamePassPurchase

!!! warning
    PromptGamePassPurchas has a third optional parameter which if provided will run once when the player either completes the purchase or closes out of the prompt. This parameter is only available on the server, is bad practice to process payments on the client anyways.

| Parameter | Type | Required |
| - | - | - |
| player | [Player] | ✓ |
| gamePassId | [number] | ✓ |
| handler | (wasPurchase: [boolean]) -> () | |

```lua
MarketPlus:PromptGamePassPurchase(player, 0, function(wasPurchased: boolean)
    -- an optional server-only parameter, this function runs once when the
    -- player either closes out the prompt or purchases the item
end)
```

#### PromptProductPruchase
{no-change}

??? note
    PromptProductPurchase's third parameter 'equipIfPurchased' currently has no functionality and was most likely and oversight by Roblox.

| Parameter | Type | Required |
| - | - | - |
| player | [Player] | ✓ |
| productId | [number] | ✓ |
| equipIfPurchased | [boolean] | |
| currencyType | [CurrencyType] | |

```lua
MarketPlus:PromptProductPurchase(player, 3489239)
```

#### PromptAssetPurchase
{no-change}

| Parameter | Type | Required |
| - | - | - |
| player | [Player] | ✓ |
| assetId | [number] | ✓ |
| equipIfPurchased | [boolean] | |
| currencyType | [CurrencyType] | |

```lua
MarketPlus:PromptAssetPurchase(player, 4378233)
```

#### PromptBundlePurchase
{no-change}

| Parameter | Type | Required |
| - | - | - |
| player | [Player] | ✓ |
| bundleId | [number] | ✓ |

```lua
MarketPlus:PromptBundlePurchase(player, 29311233)
```

#### PromptPremiumPurchase
{no-change}

| Parameter | Type | Required |
| - | - | - |
| player | [Player] | ✓ |

```lua
MarketPlus:PromptPremiumPurchase(player)
```
