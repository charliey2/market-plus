[Player]: https://create.roblox.com/docs/reference/engine/classes/Player
[number]: https://create.roblox.com/docs/scripting/luau/numbers
[boolean]: https://create.roblox.com/docs/scripting/luau/booleans
[table]: https://create.roblox.com/docs/scripting/luau/tables
[string]: https://create.roblox.com/docs/scripting/luau/strings
[CurrencyType]: https://create.roblox.com/docs/reference/engine/enums/CurrencyType
[CurrencyType.Robux]: https://create.roblox.com/docs/reference/engine/enums/CurrencyType#Robux
[ProductPurchaseDecision]: https://create.roblox.com/docs/reference/engine/enums/ProductPurchaseDecision
[receiptInfo]: https://charliey2.github.io/market-plus/api/methods#reciptinfo

## User Prompts

!!! tip "Currency Deprecation"
    Some no-change methods may include a [CurrencyType] parameter, which has been deprecated by Roblox. It should not be used.

#### PromptGamePassPurchase

!!! warning
    PromptGamePassPurchas has a third optional parameter which if provided will run once when the player either completes the purchase or closes out of the prompt. This parameter is only available on the server, it is bad practice to process payments on the client anyways.

| Parameter | Type | Required |
| - | - | - |
| player | [Player] | ✓ |
| gamePassId | [number] | ✓ |
| handler | (wasPurchased: [boolean]) -> () | |

##### Usage

```lua
MarketPlus:PromptGamePassPurchase(player, 0, function(wasPurchased: boolean)
    -- an optional server-only parameter, this function runs once when the
    -- player either closes out the prompt or purchases the item
end)
```

#### PromptProductPruchase
{no-change}

##### Parameters

??? note
    PromptProductPurchase has a third parameter 'equipIfPurchased' which currently has no (known) functionality and was most likely and oversight by Roblox.

| Parameter | Type | Required |
| - | - | - |
| player | [Player] | ✓ |
| productId | [number] | ✓ |
| equipIfPurchased | [boolean] | |
| currencyType | [CurrencyType] | |

##### Usage

```lua
MarketPlus:PromptProductPurchase(player, 3489239)
```

#### PromptAssetPurchase
{no-change}

##### Parameters

| Parameter | Type | Required |
| - | - | - |
| player | [Player] | ✓ |
| assetId | [number] | ✓ |
| equipIfPurchased | [boolean] | |
| currencyType | [CurrencyType] | |

##### Usage

```lua
MarketPlus:PromptAssetPurchase(player, 4378233)
```

#### PromptBundlePurchase
{no-change}

##### Parameters

| Parameter | Type | Required |
| - | - | - |
| player | [Player] | ✓ |
| bundleId | [number] | ✓ |

##### Usage

```lua
MarketPlus:PromptBundlePurchase(player, 29311233)
```

#### PromptPremiumPurchase
{no-change}

##### Parameters

| Parameter | Type | Required |
| - | - | - |
| player | [Player] | ✓ |

##### Usage

```lua
MarketPlus:PromptPremiumPurchase(player)
```

## Other

#### BindHandlerFunctionToProductPurchase 
{server-only}

!!! tip
    It is important that you bind all your developer product purchase handlers before prompting users to make purchases, otherwise players may recive purchase errors.

##### Parameters

| Parameter | Type | Required |
| - | - | - |
| productId | [number] | ✓ |
| handler | ([receiptInfo]: [table]) -> ([ProductPurchaseDecision]) | ✓ |

##### reciptInfo

| Value | Type | Note |
| - | - | - |
| <span style="white-space: nowrap">`PurchaseId`</span> | [string] | A unique identifier for the specific purchase. |
| <span style="white-space: nowrap">`PlayerId`</span> | [number] | The user ID of the player who made the purchase. |
| <span style="white-space: nowrap">`ProductId`</span> | [number] | The ID of the purchased product. |
| <span style="white-space: nowrap">`PlaceIdWherePurchased`</span> | [number] | The place ID in which the purchase was made; not necessarily the same as the current place's ID. |
| <span style="white-space: nowrap">`CurrencySpent`</span> | [number] | The amount of currency spent in the transaction. |
| <span style="white-space: nowrap">`CurrencyType`</span> | [CurrencyType] | The type of currency spent in the purchase; always [CurrencyType.Robux]. |

##### Usage

```lua
MarketPlus:BindToProductPurchase(productId, function(receiptInfo: table)
    -- code to run

    -- must return a ProductPurchaseDecision enum
    return Enum.ProductPurchaseDecision.PurchaseGranted -- or
    return Enum.ProductPurchaseDecision.NotProcessedYet
end)
```
