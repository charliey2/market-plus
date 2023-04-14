export type ReceiptInfo = {
    PurchaseId: string,
    PlayerId: number,
    ProductId: number,
    PlaceIdWherePurchased: number,
    CurrencySpent: number,
    CurrencyType: Enum.CurrencyType
}

local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local DataStoreService = game:GetService("DataStoreService")
local RunService = game:GetService("RunService")

local Utility = require(script.Utility)
local GoodSignal = require(script.Signal)

local isClient: boolean = RunService:IsClient()
local isServer: boolean = RunService:IsServer()

local marketPlusRemoteEvent: RemoteEvent = isServer and Utility.Create("RemoteEvent", {Parent = script}) or isClient and script:WaitForChild("RemoteEvent")
local marketData = {}

local marketPlus = {}

-- init
do
    if isServer then
        marketData.server = {
            productBinds = {}
        }

        -- connect developer product purchases
        MarketplaceService.ProcessReceipt = function(receiptInfo: ReceiptInfo)
            local stringedProductId: string = tostring(receiptInfo.ProductId)

            local handler: (ReceiptInfo) -> (Enum.ProductPurchaseDecision) = marketPlus.server.productBinds[stringedProductId]

            if handler then
                local handlerResult: Enum.ProductPurchaseDecision? = handler(receiptInfo)

                if not handlerResult or (handlerResult ~= Enum.ProductPurchaseDecision.NotProcessedYet and handlerResult ~= Enum.ProductPurchaseDecision.PurchaseGranted) then
                    warn(string.format("[MarketPlus]: user attempted to purchase developer product with productId %s, which has an invalid return type (must return Enum.ProductPurchaseDecision)", stringedProductId))
                    return Enum.ProductPurchaseDecision.NotProcessedYet
                end
            else
                warn(string.format("[MarketPlus]: user attempted to purchase developer product with productId %s, which isn't bound to a handler function", stringedProductId))
                return Enum.ProductPurchaseDecision.NotProcessedYet
            end
        end
    elseif isClient then
        marketData.client = {}
    end
    marketData.shared = {}
end

-- server only functions
local function server_bindToProductPurchase(self, productId: number, handler: (receiptInfo: ReceiptInfo) -> (Enum.ProductPurchaseDecision)) -- "BindHandlerToProductPurchase"
    if not productId or typeof(productId) ~= "number" then -- avoid using assert to increase script performance
        error("[MarketPlus][BindHandlerToProductPurchase]: invalid arg #1 'productId', expected number", 1)
    end
    if not handler or typeof(handler) ~= "function" then
        error("[MarketPlus][BindHandlerToProductPurchase]: invalid arg #2 'handler', expected function", 1)
    end

    local stringedProductId: string = tostring(productId)

    if marketData.server.productBinds[stringedProductId] then -- warn that the product is already bound, but we are overriding it
        warn(string.format("[MarketPlus][BindHandlerToProductPurchase]: product %d is already bound, it will be overridden by this call", productId))
    end

    marketData.server.productBinds[stringedProductId] = handler
end
local function server_unbindProductPurchase(productId: number) -- "UnbindProductPurchaseHandler"
    if not productId or typeof(productId) ~= "number" then
        error("[MarketPlus][BindHandlerToProductPurchase]: invalid arg #1 'productId', expected number", 1)
    end
end

marketPlus.BindHandlerToProductPurchase = isServer and server_bindToProductPurchase
marketPlus.UnbindProductPurchaseHandler = isServer and server_unbindProductPurchase

--

return marketPlus