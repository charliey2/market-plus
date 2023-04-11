## Script Examples

#### Product Purchase
{script}

This `Script` prompts a developer product purchase to any player that clicks a part in workspace, it also handles the purchase recipt and gives coins when a purchase is completed.

```lua
-- define our product configs
local PRODUCT_ID: number = 0000000
local COINS_TO_GIVE: number = 100

-- define our services & modules
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local MarketPlus = require(ReplicatedStorage:WaitForChild("MarketPlus"))

-- this script assumes the part and click detector are already in workspace
local clickPart: Part = workspace:WaitForChild("ClickPart")
local clickDetector: ClickDetector = clickPart:WaitForChild("ClickDetector")

-- connect the ClickDetector
clickDetector.MouseClick:Connect(function(playerWhoClicked: Player)
    -- prompt with MarketPlus
    MarketPlus:PromptProductPurchase(playerWhoClicked, PRODUCT_ID)
end)

-- setup our bind for the product
MarketPlus:BindHandlerFunctionToProductPurchase(PRODUCT_ID, function(receiptInfo: table)
    local playerWhoPurchased: Player? = Players:GetPlayerByUserId(receiptInfo.PlayerId)

    if playerWhoPurchased then
        -- the player is in the game
        local leaderStats: Folder = playerWhoPurchased:WaitForChild("leaderstats")
        local playerCoinsValue: NumberValue = leaderStats:WaitForChild("Coins")

        -- give the coins
        playerCoinsValue.Value += COINS_TO_GIVE

        -- return that the purchase was successful
        return Enum.ProductPurchaseDecision.PurchaseGranted
    end
    
    -- the player wasnt in the game
    return Enum.ProductPurchaseDecision.NotProcessedYet
end)
```

#### Client Processor
{local-script}