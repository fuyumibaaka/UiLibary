pcall(function()
    local ui = game:GetService('CoreGui'):FindFirstChild('AZZURA_UI')
    if ui then ui:Remove() end
end)

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

local Library = {}
local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()

-- Warna Theme
local Colors = {
    Red = Color3.fromRGB(200, 20, 40),
    DarkRed = Color3.fromRGB(134, 10, 30),
    HoverRed = Color3.fromRGB(220, 30, 50),
    Black = Color3.fromRGB(20, 20, 20),
    DarkBlack = Color3.fromRGB(15, 15, 15),
    Gray = Color3.fromRGB(40, 40, 40),
    LightGray = Color3.fromRGB(60, 60, 60),
    White = Color3.fromRGB(255, 255, 255),
}

-- =============================================
-- CREATE WINDOW
-- =============================================
function Library:Window(title)
    local ui = Instance.new("ScreenGui")
    ui.Name = "AZZURA_UI"
    ui.Parent = game:GetService("CoreGui")
    ui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ui.IgnoreGuiInset = true
    ui.ResetOnSpawn = false

    -- Main Frame
    local Main = Instance.new("Frame")
    Main.Name = "Main"
    Main.Parent = ui
    Main.BackgroundColor3 = Colors.Black
    Main.BorderSizePixel = 0
    Main.Position = UDim2.new(0.377, 0, 0.3, 0)
    Main.Size = UDim2.new(0, 470, 0, 320)
    Main.Active = true
    Main.Selectable = true
    Main.Visible = true

    -- Corner
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 8)
    UICorner.Parent = Main

    -- Border
    local Border = Instance.new("UIStroke")
    Border.Parent = Main
    Border.Thickness = 2
    Border.Color = Colors.Red

    -- Make draggable
    local dragging = false
    local dragInput, dragStart, startPos

    local function updateInput(input)
        local Delta = input.Position - dragStart
        Main.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + Delta.X,
            startPos.Y.Scale, startPos.Y.Offset + Delta.Y
        )
    end

    Main.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = Main.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    Main.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            updateInput(input)
        end
    end)

    -- Top Bar
    local Top = Instance.new("Frame")
    Top.Name = "Top"
    Top.Parent = Main
    Top.BackgroundColor3 = Colors.DarkBlack
    Top.BorderSizePixel = 0
    Top.Size = UDim2.new(1, 0, 0, 38)

    local TopCorner = Instance.new("UICorner")
    TopCorner.CornerRadius = UDim.new(0, 8)
    TopCorner.Parent = Top

    local TopCover = Instance.new("Frame")
    TopCover.Name = "Cover"
    TopCover.Parent = Top
    TopCover.AnchorPoint = Vector2.new(0.5, 1)
    TopCover.BackgroundColor3 = Colors.DarkBlack
    TopCover.BorderSizePixel = 0
    TopCover.Position = UDim2.new(0.5, 0, 1, 0)
    TopCover.Size = UDim2.new(1, 0, 0, 4)

    -- Title
    local GameName = Instance.new("TextLabel")
    GameName.Name = "GameName"
    GameName.Parent = Top
    GameName.AnchorPoint = Vector2.new(0, 0.5)
    GameName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    GameName.BackgroundTransparency = 1.000
    GameName.Position = UDim2.new(0, 12, 0.5, 0)
    GameName.Size = UDim2.new(0, 200, 0, 22)
    GameName.Font = Enum.Font.Gothom
    GameName.Text = title or "AZZURA UI"
    GameName.TextColor3 = Colors.Red
    GameName.TextSize = 16.000
    GameName.TextXAlignment = Enum.TextXAlignment.Left

    -- =============================================
    -- MINIMIZE BUTTON
    -- =============================================
    local MinimizeBtn = Instance.new("ImageButton")
    MinimizeBtn.Name = "MinimizeBtn"
    MinimizeBtn.Parent = Top
    MinimizeBtn.AnchorPoint = Vector2.new(1, 0.5)
    MinimizeBtn.BackgroundColor3 = Colors.DarkBlack
    MinimizeBtn.BackgroundTransparency = 0.8
    MinimizeBtn.Position = UDim2.new(1, -48, 0.5, 0)
    MinimizeBtn.Size = UDim2.new(0, 26, 0, 26)
    MinimizeBtn.AutoButtonColor = false

    local MinCorner = Instance.new("UICorner")
    MinCorner.CornerRadius = UDim.new(0, 4)
    MinCorner.Parent = MinimizeBtn

    -- Icon Minimize (garis)
    local MinIcon = Instance.new("Frame")
    MinIcon.Name = "MinIcon"
    MinIcon.Parent = MinimizeBtn
    MinIcon.AnchorPoint = Vector2.new(0.5, 0.5)
    MinIcon.BackgroundColor3 = Colors.White
    MinIcon.BorderSizePixel = 0
    MinIcon.Position = UDim2.new(0.5, 0, 0.5, 0)
    MinIcon.Size = UDim2.new(0, 14, 0, 2)

    local MinCorner2 = Instance.new("UICorner")
    MinCorner2.CornerRadius = UDim.new(0, 2)
    MinCorner2.Parent = MinIcon

    -- Close Button
    local Close = Instance.new("ImageButton")
    Close.Name = "Close"
    Close.Parent = Top
    Close.AnchorPoint = Vector2.new(1, 0.5)
    Close.BackgroundColor3 = Colors.DarkBlack
    Close.BackgroundTransparency = 0.8
    Close.Position = UDim2.new(1, -12, 0.5, 0)
    Close.Size = UDim2.new(0, 26, 0, 26)
    Close.AutoButtonColor = false

    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 4)
    CloseCorner.Parent = Close

    local CloseIcon = Instance.new("TextLabel")
    CloseIcon.Name = "CloseIcon"
    CloseIcon.Parent = Close
    CloseIcon.AnchorPoint = Vector2.new(0.5, 0.5)
    CloseIcon.BackgroundTransparency = 1
    CloseIcon.Position = UDim2.new(0.5, 0, 0.5, 0)
    CloseIcon.Size = UDim2.new(1, 0, 1, 0)
    CloseIcon.Font = Enum.Font.Gothom
    CloseIcon.Text = "✕"
    CloseIcon.TextColor3 = Colors.White
    CloseIcon.TextSize = 16

    -- Tabs Container
    local Tabs = Instance.new("Frame")
    Tabs.Name = "Tabs"
    Tabs.Parent = Main
    Tabs.BackgroundColor3 = Colors.DarkBlack
    Tabs.BorderSizePixel = 0
    Tabs.Position = UDim2.new(0, 0, 0, 39)
    Tabs.Size = UDim2.new(0, 115, 1, -39)

    local TabsCorner = Instance.new("UICorner")
    TabsCorner.CornerRadius = UDim.new(0, 8)
    TabsCorner.Parent = Tabs

    local TabsContainer = Instance.new("Frame")
    TabsContainer.Name = "TabsContainer"
    TabsContainer.Parent = Tabs
    TabsContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TabsContainer.BackgroundTransparency = 1.000
    TabsContainer.Size = UDim2.new(1, 0, 1, 0)

    local TabsList = Instance.new("UIListLayout")
    TabsList.Name = "TabsList"
    TabsList.Parent = TabsContainer
    TabsList.HorizontalAlignment = Enum.HorizontalAlignment.Center
    TabsList.SortOrder = Enum.SortOrder.LayoutOrder
    TabsList.Padding = UDim.new(0, 5)

    local TabsPadding = Instance.new("UIPadding")
    TabsPadding.Parent = TabsContainer
    TabsPadding.PaddingTop = UDim.new(0, 8)

    -- Pages Container
    local Pages = Instance.new("Frame")
    Pages.Name = "Pages"
    Pages.Parent = Main
    Pages.BackgroundColor3 = Colors.Black
    Pages.BorderSizePixel = 0
    Pages.Position = UDim2.new(0, 123, 0, 46)
    Pages.Size = UDim2.new(1, -132, 1, -55)

    local PagesCorner = Instance.new("UICorner")
    PagesCorner.CornerRadius = UDim.new(0, 8)
    PagesCorner.Parent = Pages

    -- =============================================
    -- MINIMIZE FUNCTION
    -- =============================================
    local isMinimized = false
    local minimizedLabel = nil

    local function MinimizeUI()
        isMinimized = not isMinimized

        if isMinimized then
            Main.Size = UDim2.new(0, 180, 0, 40)
            Main.Position = UDim2.new(0.8, 0, 0.9, 0)
            Tabs.Visible = false
            Pages.Visible = false

            if not minimizedLabel then
                minimizedLabel = Instance.new("TextLabel")
                minimizedLabel.Name = "MinimizedLabel"
                minimizedLabel.Parent = Main
                minimizedLabel.BackgroundColor3 = Colors.DarkBlack
                minimizedLabel.BackgroundTransparency = 0
                minimizedLabel.Size = UDim2.new(1, 0, 1, 0)
                minimizedLabel.Font = Enum.Font.Gothom
                minimizedLabel.Text = "⚡ AZZURA"
                minimizedLabel.TextColor3 = Colors.Red
                minimizedLabel.TextSize = 16
                minimizedLabel.TextScaled = true
                minimizedLabel.TextXAlignment = Enum.TextXAlignment.Center

                local labelCorner = Instance.new("UICorner")
                labelCorner.CornerRadius = UDim.new(0, 8)
                labelCorner.Parent = minimizedLabel

                local labelStroke = Instance.new("UIStroke")
                labelStroke.Parent = minimizedLabel
                labelStroke.Thickness = 2
                labelStroke.Color = Colors.Red

                minimizedLabel.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        MinimizeUI()
                    end
                end)
            else
                minimizedLabel.Visible = true
            end

            -- Ubah icon minimize jadi "+"
            for _, child in pairs(MinIcon:GetChildren()) do
                child:Destroy()
            end
            MinIcon.Size = UDim2.new(0, 14, 0, 14)
            MinIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            MinIcon.BackgroundTransparency = 0

            local hLine = Instance.new("Frame")
            hLine.Name = "HLine"
            hLine.Parent = MinIcon
            hLine.AnchorPoint = Vector2.new(0.5, 0.5)
            hLine.BackgroundColor3 = Colors.Black
            hLine.BorderSizePixel = 0
            hLine.Position = UDim2.new(0.5, 0, 0.5, 0)
            hLine.Size = UDim2.new(0, 10, 0, 2)

            local vLine = Instance.new("Frame")
            vLine.Name = "VLine"
            vLine.Parent = MinIcon
            vLine.AnchorPoint = Vector2.new(0.5, 0.5)
            vLine.BackgroundColor3 = Colors.Black
            vLine.BorderSizePixel = 0
            vLine.Position = UDim2.new(0.5, 0, 0.5, 0)
            vLine.Size = UDim2.new(0, 2, 0, 10)

        else
            Main.Size = UDim2.new(0, 470, 0, 320)
            Main.Position = UDim2.new(0.377, 0, 0.3, 0)
            Tabs.Visible = true
            Pages.Visible = true

            if minimizedLabel then
                minimizedLabel.Visible = false
            end

            for _, child in pairs(MinIcon:GetChildren()) do
                child:Destroy()
            end
            MinIcon.Size = UDim2.new(0, 14, 0, 2)
            MinIcon.BackgroundColor3 = Colors.White
            MinIcon.BackgroundTransparency = 0
        end
    end

    MinimizeBtn.MouseButton1Click:Connect(MinimizeUI)
    MinimizeBtn.TouchTap:Connect(MinimizeUI)

    Close.MouseButton1Click:Connect(function()
        ui:Destroy()
    end)

    Close.TouchTap:Connect(function()
        ui:Destroy()
    end)

    -- Hover effect
    Close.MouseEnter:Connect(function()
        TweenService:Create(Close, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = Colors.Red}):Play()
        TweenService:Create(CloseIcon, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextColor3 = Colors.White}):Play()
    end)

    Close.MouseLeave:Connect(function()
        TweenService:Create(Close, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = Colors.DarkBlack}):Play()
        TweenService:Create(CloseIcon, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextColor3 = Colors.White}):Play()
    end)

    MinimizeBtn.MouseEnter:Connect(function()
        TweenService:Create(MinimizeBtn, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = Colors.Gray}):Play()
    end)

    MinimizeBtn.MouseLeave:Connect(function()
        TweenService:Create(MinimizeBtn, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = Colors.DarkBlack}):Play()
    end)

    -- =============================================
    -- TAB FUNCTION
    -- =============================================
    local TabFunctions = {}

    function TabFunctions:Tab(title)
        local TabButton = Instance.new("TextButton")
        TabButton.Name = "TabButton"
        TabButton.Parent = TabsContainer
        TabButton.BackgroundColor3 = Colors.Red
        TabButton.BackgroundTransparency = 1
        TabButton.Size = UDim2.new(1, -12, 0, 30)
        TabButton.AutoButtonColor = false
        TabButton.Font = Enum.Font.Gothom
        TabButton.Text = title or "Tab"
        TabButton.TextColor3 = Colors.White
        TabButton.TextSize = 13

        local TabCorner = Instance.new("UICorner")
        TabCorner.CornerRadius = UDim.new(0, 6)
        TabCorner.Parent = TabButton

        -- Page
        local Page = Instance.new("ScrollingFrame")
        Page.Name = "Page"
        Page.Visible = false
        Page.Parent = Pages
        Page.Active = true
        Page.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Page.BackgroundTransparency = 1.000
        Page.BorderSizePixel = 0
        Page.Size = UDim2.new(1, 0, 1, 0)
        Page.CanvasPosition = Vector2.new(0, 0)
        Page.ScrollBarThickness = 3
        Page.ScrollBarImageColor3 = Colors.Red

        local PageList = Instance.new("UIListLayout")
        PageList.Parent = Page
        PageList.HorizontalAlignment = Enum.HorizontalAlignment.Center
        PageList.SortOrder = Enum.SortOrder.LayoutOrder
        PageList.Padding = UDim.new(0, 6)

        local PagePadding = Instance.new("UIPadding")
        PagePadding.Parent = Page
        PagePadding.PaddingTop = UDim.new(0, 5)
        PagePadding.PaddingBottom = UDim.new(0, 5)

        PageList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            Page.CanvasSize = UDim2.new(0, 0, 0, PageList.AbsoluteContentSize.Y + 10)
        end)

        -- Tab click
        TabButton.MouseButton1Click:Connect(function()
            for _, v in next, Pages:GetChildren() do
                if v:IsA("ScrollingFrame") then
                    v.Visible = false
                end
            end
            Page.Visible = true

            for _, v in next, TabsContainer:GetChildren() do
                if v.Name == "TabButton" then
                    TweenService:Create(v, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
                end
            end

            TweenService:Create(TabButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0.7}):Play()
        end)

        TabButton.TouchTap:Connect(function()
            TabButton.MouseButton1Click:Fire()
        end)

        -- First tab selected
        if #TabsContainer:GetChildren() == 1 then
            Page.Visible = true
            TweenService:Create(TabButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0.7}):Play()
        end

        -- =============================================
        -- ELEMENTS
        -- =============================================
        local Elements = {}

        -- Button
        function Elements:Button(text, callback)
            local Button = Instance.new("TextButton")
            Button.Name = "Button"
            Button.Parent = Page
            Button.BackgroundColor3 = Colors.DarkRed
            Button.BorderSizePixel = 0
            Button.Size = UDim2.new(1, -6, 0, 34)
            Button.AutoButtonColor = false
            Button.Font = Enum.Font.Gothom
            Button.Text = text or "Button"
            Button.TextColor3 = Colors.White
            Button.TextSize = 14

            local ButtonCorner = Instance.new("UICorner")
            ButtonCorner.CornerRadius = UDim.new(0, 6)
            ButtonCorner.Parent = Button

            Button.MouseEnter:Connect(function()
                TweenService:Create(Button, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = Colors.HoverRed}):Play()
            end)

            Button.MouseLeave:Connect(function()
                TweenService:Create(Button, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = Colors.DarkRed}):Play()
            end)

            Button.MouseButton1Click:Connect(function()
                if callback then callback() end
            end)

            Button.TouchTap:Connect(function()
                if callback then callback() end
            end)
        end

        -- Toggle
        function Elements:Toggle(text, default, callback)
            local Toggle = Instance.new("TextButton")
            Toggle.Name = "Toggle"
            Toggle.Parent = Page
            Toggle.BackgroundColor3 = Colors.Gray
            Toggle.BorderSizePixel = 0
            Toggle.Size = UDim2.new(1, -6, 0, 34)
            Toggle.AutoButtonColor = false
            Toggle.Font = Enum.Font.SourceSans
            Toggle.Text = ""
            Toggle.TextColor3 = Color3.fromRGB(0, 0, 0)
            Toggle.TextSize = 14

            local ToggleCorner = Instance.new("UICorner")
            ToggleCorner.CornerRadius = UDim.new(0, 6)
            ToggleCorner.Parent = Toggle

            local Title = Instance.new("TextLabel")
            Title.Name = "Title"
            Title.Parent = Toggle
            Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Title.BackgroundTransparency = 1.000
            Title.Position = UDim2.new(0, 8, 0, 0)
            Title.Size = UDim2.new(1, -6, 1, 0)
            Title.Font = Enum.Font.Gothom
            Title.Text = text or "Toggle"
            Title.TextColor3 = Colors.White
            Title.TextSize = 14
            Title.TextXAlignment = Enum.TextXAlignment.Left

            local ToggleFrame = Instance.new("Frame")
            ToggleFrame.Name = "ToggleFrame"
            ToggleFrame.Parent = Toggle
            ToggleFrame.AnchorPoint = Vector2.new(1, 0.5)
            ToggleFrame.BackgroundColor3 = Colors.Red
            ToggleFrame.BackgroundTransparency = 1.000
            ToggleFrame.BorderSizePixel = 0
            ToggleFrame.Position = UDim2.new(1, -8, 0.5, 0)
            ToggleFrame.Size = UDim2.new(0, 14, 0, 14)

            local ToggleCorner2 = Instance.new("UICorner")
            ToggleCorner2.CornerRadius = UDim.new(0, 3)
            ToggleCorner2.Parent = ToggleFrame

            local Check = Instance.new("ImageLabel")
            Check.Name = "Check"
            Check.Parent = ToggleFrame
            Check.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Check.BackgroundTransparency = 1.000
            Check.Position = UDim2.new(-0.2, 0, -0.2, 0)
            Check.Size = UDim2.new(0, 20, 0, 20)
            Check.Image = "http://www.roblox.com/asset/?id=7812909048"
            Check.ImageTransparency = 1
            Check.ScaleType = Enum.ScaleType.Fit

            local ToggleStroke = Instance.new("UIStroke")
            ToggleStroke.Parent = ToggleFrame
            ToggleStroke.LineJoinMode = Enum.LineJoinMode.Round
            ToggleStroke.Thickness = 2
            ToggleStroke.Color = Colors.Red

            local toggled = default or false

            if toggled then
                TweenService:Create(ToggleFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
                TweenService:Create(Check, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageTransparency = 0}):Play()
            end

            Toggle.MouseButton1Click:Connect(function()
                toggled = not toggled

                if toggled then
                    TweenService:Create(ToggleFrame, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
                    TweenService:Create(Check, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageTransparency = 0}):Play()
                else
                    TweenService:Create(ToggleFrame, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
                    TweenService:Create(Check, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageTransparency = 1}):Play()
                end

                if callback then callback(toggled) end
            end)

            Toggle.TouchTap:Connect(function()
                Toggle.MouseButton1Click:Fire()
            end)
        end

        -- Label
        function Elements:Label(text)
            local Label = Instance.new("TextLabel")
            Label.Parent = Page
            Label.BackgroundColor3 = Colors.DarkBlack
            Label.BorderSizePixel = 0
            Label.Size = UDim2.new(1, -6, 0, 34)
            Label.Font = Enum.Font.Gothom
            Label.Text = "  " .. (text or "Label")
            Label.TextColor3 = Colors.White
            Label.TextSize = 14
            Label.TextXAlignment = Enum.TextXAlignment.Left

            local LabelCorner = Instance.new("UICorner")
            LabelCorner.CornerRadius = UDim.new(0, 6)
            LabelCorner.Parent = Label
        end

        -- Slider
        function Elements:Slider(text, min, max, default, callback)
            local Slider = Instance.new("Frame")
            Slider.Name = "Slider"
            Slider.Parent = Page
            Slider.BackgroundColor3 = Colors.Gray
            Slider.Size = UDim2.new(1, -6, 0, 48)

            local SliderCorner = Instance.new("UICorner")
            SliderCorner.CornerRadius = UDim.new(0, 6)
            SliderCorner.Parent = Slider

            local Title = Instance.new("TextLabel")
            Title.Name = "Title"
            Title.Parent = Slider
            Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Title.BackgroundTransparency = 1.000
            Title.Position = UDim2.new(0, 8, 0, 0)
            Title.Size = UDim2.new(1, -6, 0, 34)
            Title.Font = Enum.Font.Gothom
            Title.Text = text or "Slider"
            Title.TextColor3 = Colors.White
            Title.TextSize = 14
            Title.TextXAlignment = Enum.TextXAlignment.Left

            local Value = Instance.new("TextLabel")
            Value.Name = "Value"
            Value.Parent = Slider
            Value.AnchorPoint = Vector2.new(1, 0)
            Value.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Value.BackgroundTransparency = 1.000
            Value.Position = UDim2.new(1, -10, 0, 0)
            Value.Size = UDim2.new(1, 0, 0, 34)
            Value.Font = Enum.Font.Gothom
            Value.Text = tostring(default)
            Value.TextColor3 = Colors.White
            Value.TextSize = 14
            Value.TextXAlignment = Enum.TextXAlignment.Right

            local SliderClick = Instance.new("TextButton")
            SliderClick.Name = "SliderClick"
            SliderClick.Parent = Slider
            SliderClick.AnchorPoint = Vector2.new(0.5, 1)
            SliderClick.BackgroundColor3 = Colors.DarkBlack
            SliderClick.Position = UDim2.new(0.5, 0, 1, -8)
            SliderClick.Size = UDim2.new(1, -12, 0, 6)
            SliderClick.AutoButtonColor = false
            SliderClick.Text = ""

            local SliderClickCorner = Instance.new("UICorner")
            SliderClickCorner.CornerRadius = UDim.new(0, 6)
            SliderClickCorner.Parent = SliderClick

            local SliderDrag = Instance.new("Frame")
            SliderDrag.Name = "SliderDrag"
            SliderDrag.Parent = SliderClick
            SliderDrag.BackgroundColor3 = Colors.Red
            SliderDrag.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)

            local SliderDragCorner = Instance.new("UICorner")
            SliderDragCorner.CornerRadius = UDim.new(0, 6)
            SliderDragCorner.Parent = SliderDrag

            local dragging = false

            local function slide(input)
                local pos = UDim2.new(
                    math.clamp((input.Position.X - SliderClick.AbsolutePosition.X) / SliderClick.AbsoluteSize.X, 0, 1),
                    0, 0, 6
                )
                SliderDrag:TweenSize(pos, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.15, true)
                local value = math.floor(min + (pos.X.Scale * (max - min)))
                Value.Text = tostring(value)
                if callback then callback(value) end
            end

            SliderClick.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    slide(input)
                    dragging = true
                end
            end)

            SliderClick.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = false
                end
            end)

            UserInputService.InputChanged:Connect(function(input)
                if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                    slide(input)
                end
            end)
        end

        -- Keybind
        function Elements:Keybind(text, defaultKey, callback)
            local Keybind = Instance.new("TextButton")
            Keybind.Name = "Keybind"
            Keybind.Parent = Page
            Keybind.BackgroundColor3 = Colors.Gray
            Keybind.Size = UDim2.new(1, -6, 0, 34)
            Keybind.AutoButtonColor = false
            Keybind.Font = Enum.Font.SourceSans
            Keybind.Text = ""
            Keybind.TextColor3 = Color3.fromRGB(0, 0, 0)
            Keybind.TextSize = 14

            local KeybindCorner = Instance.new("UICorner")
            KeybindCorner.CornerRadius = UDim.new(0, 6)
            KeybindCorner.Parent = Keybind

            local Title = Instance.new("TextLabel")
            Title.Name = "Title"
            Title.Parent = Keybind
            Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Title.BackgroundTransparency = 1.000
            Title.Position = UDim2.new(0, 8, 0, 0)
            Title.Size = UDim2.new(1, -6, 1, 0)
            Title.Font = Enum.Font.Gothom
            Title.Text = text or "Keybind"
            Title.TextColor3 = Colors.White
            Title.TextSize = 14
            Title.TextXAlignment = Enum.TextXAlignment.Left

            local CurrentKey = Instance.new("TextLabel")
            CurrentKey.Name = "CurrentKey"
            CurrentKey.Parent = Keybind
            CurrentKey.AnchorPoint = Vector2.new(1, 0.5)
            CurrentKey.BackgroundColor3 = Colors.DarkBlack
            CurrentKey.Position = UDim2.new(1, -6, 0.5, 0)
            CurrentKey.Size = UDim2.new(-0, 46, 0, 24)
            CurrentKey.Font = Enum.Font.Gothom
            CurrentKey.Text = defaultKey.Name or ". . ."
            CurrentKey.TextColor3 = Colors.White
            CurrentKey.TextSize = 14

            local CurrentKeyCorner = Instance.new("UICorner")
            CurrentKeyCorner.CornerRadius = UDim.new(0, 4)
            CurrentKeyCorner.Parent = CurrentKey

            local key = defaultKey

            Keybind.MouseButton1Click:Connect(function()
                CurrentKey.Text = ". . ."
                local input
                input = UserInputService.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.Keyboard then
                        key = input.KeyCode
                        CurrentKey.Text = key.Name
                        if callback then callback(key) end
                        input:Disconnect()
                    end
                end)
            end)

            Keybind.TouchTap:Connect(function()
                Keybind.MouseButton1Click:Fire()
            end)
        end

        -- Dropdown
        function Elements:Dropdown(text, options, callback, multiSelect)
            multiSelect = multiSelect or false
            options = options or {}
            callback = callback or function() end

            local Dropdown = Instance.new("Frame")
            Dropdown.Name = "Dropdown"
            Dropdown.Parent = Page
            Dropdown.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Dropdown.BackgroundTransparency = 1.000
            Dropdown.BorderSizePixel = 0
            Dropdown.ClipsDescendants = true
            Dropdown.Size = UDim2.new(1, -6, 0, 34)

            local DropdownList = Instance.new("UIListLayout")
            DropdownList.Parent = Dropdown
            DropdownList.HorizontalAlignment = Enum.HorizontalAlignment.Center
            DropdownList.SortOrder = Enum.SortOrder.LayoutOrder
            DropdownList.Padding = UDim.new(0, 5)

            local Choose = Instance.new("Frame")
            Choose.Name = "Choose"
            Choose.Parent = Dropdown
            Choose.BackgroundColor3 = Colors.Gray
            Choose.BorderSizePixel = 0
            Choose.Size = UDim2.new(1, 0, 0, 34)

            local ChooseCorner = Instance.new("UICorner")
            ChooseCorner.CornerRadius = UDim.new(0, 6)
            ChooseCorner.Parent = Choose

            local Title = Instance.new("TextLabel")
            Title.Name = "Title"
            Title.Parent = Choose
            Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Title.BackgroundTransparency = 1.000
            Title.Position = UDim2.new(0, 8, 0, 0)
            Title.Size = UDim2.new(1, -6, 1, 0)
            Title.Font = Enum.Font.Gothom
            Title.Text = text or "Dropdown"
            Title.TextColor3 = Colors.White
            Title.TextSize = 14
            Title.TextXAlignment = Enum.TextXAlignment.Left

            local Arrow = Instance.new("ImageButton")
            Arrow.Name = "Arrow"
            Arrow.Parent = Choose
            Arrow.AnchorPoint = Vector2.new(1, 0.5)
            Arrow.BackgroundTransparency = 1.000
            Arrow.LayoutOrder = 10
            Arrow.Position = UDim2.new(1, -2, 0.5, 0)
            Arrow.Size = UDim2.new(0, 28, 0, 28)
            Arrow.ZIndex = 2
            Arrow.Image = "rbxassetid://3926307971"
            Arrow.ImageColor3 = Colors.Red
            Arrow.ImageRectOffset = Vector2.new(324, 524)
            Arrow.ImageRectSize = Vector2.new(36, 36)
            Arrow.ScaleType = Enum.ScaleType.Crop

            local OptionHolder = Instance.new("Frame")
            OptionHolder.Name = "OptionHolder"
            OptionHolder.Parent = Dropdown
            OptionHolder.BackgroundColor3 = Colors.Gray
            OptionHolder.BorderSizePixel = 0
            OptionHolder.Position = UDim2.new(0, 0, 0, 34)
            OptionHolder.Size = UDim2.new(1, 0, 0, 0)

            local OptionHolderCorner = Instance.new("UICorner")
            OptionHolderCorner.CornerRadius = UDim.new(0, 6)
            OptionHolderCorner.Parent = OptionHolder

            local OptionList = Instance.new("UIListLayout")
            OptionList.Name = "OptionList"
            OptionList.Parent = OptionHolder
            OptionList.HorizontalAlignment = Enum.HorizontalAlignment.Center
            OptionList.SortOrder = Enum.SortOrder.LayoutOrder
            OptionList.Padding = UDim.new(0, 5)

            local OptionPadding = Instance.new("UIPadding")
            OptionPadding.Parent = OptionHolder
            OptionPadding.PaddingTop = UDim.new(0, 8)
            OptionPadding.PaddingBottom = UDim.new(0, 8)

            local dropped = false
            local selected = {}

            local function updateTitle()
                if multiSelect then
                    local selectedList = {}
                    for item, _ in pairs(selected) do
                        table.insert(selectedList, item)
                    end
                    if #selectedList > 0 then
                        Title.Text = text .. ": " .. table.concat(selectedList, ", ")
                    else
                        Title.Text = text
                    end
                end
            end

            -- Create options
            for _, option in ipairs(options) do
                local Option = Instance.new("TextButton")
                Option.Name = "Option"
                Option.Parent = OptionHolder
                Option.BackgroundColor3 = Colors.DarkRed
                Option.BorderSizePixel = 0
                Option.Size = UDim2.new(1, -16, 0, 30)
                Option.AutoButtonColor = false
                Option.Font = Enum.Font.Gothom
                Option.Text = option
                Option.TextColor3 = Colors.White
                Option.TextSize = 14

                local OptionCorner = Instance.new("UICorner")
                OptionCorner.CornerRadius = UDim.new(0, 6)
                OptionCorner.Parent = Option

                if multiSelect then
                    local Checkmark = Instance.new("ImageLabel")
                    Checkmark.Name = "Checkmark"
                    Checkmark.Parent = Option
                    Checkmark.BackgroundTransparency = 1
                    Checkmark.Image = "rbxassetid://6031068421"
                    Checkmark.ImageTransparency = 1
                    Checkmark.Size = UDim2.new(0, 16, 0, 16)
                    Checkmark.Position = UDim2.new(0, 8, 0.5, -8)
                end

                Option.MouseButton1Click:Connect(function()
                    if multiSelect then
                        if selected[option] then
                            selected[option] = nil
                            Option.Checkmark.ImageTransparency = 1
                        else
                            selected[option] = true
                            Option.Checkmark.ImageTransparency = 0
                        end
                        updateTitle()
                        local selectedList = {}
                        for item, _ in pairs(selected) do
                            table.insert(selectedList, item)
                        end
                        callback(selectedList)
                    else
                        callback(option)
                        Title.Text = text .. ": " .. option
                        dropped = false
                        TweenService:Create(Arrow, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Rotation = 0}):Play()
                        Dropdown:TweenSize(UDim2.new(1, -6, 0, 34), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.15, true)
                    end
                end)

                Option.TouchTap:Connect(function()
                    Option.MouseButton1Click:Fire()
                end)
            end

            OptionList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                if dropped then
                    OptionHolder.Size = UDim2.new(1, 0, 0, OptionList.AbsoluteContentSize.Y + 15)
                end
            end)

            Choose.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dropped = not dropped
                    if dropped then
                        local contentHeight = OptionList.AbsoluteContentSize.Y + 15
                        Dropdown:TweenSize(UDim2.new(1, -6, 0, 34 + contentHeight), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.15, true)
                        TweenService:Create(Arrow, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Rotation = 180}):Play()
                    else
                        TweenService:Create(Arrow, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Rotation = 0}):Play()
                        Dropdown:TweenSize(UDim2.new(1, -6, 0, 34), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.15, true)
                    end
                end
            end)

            Choose.TouchTap:Connect(function()
                Choose.InputBegan:Fire(UserInputService.CreateInputEvent(
                    Enum.UserInputType.MouseButton1,
                    Enum.UserInputState.Begin,
                    0,
                    Vector2.new(0, 0)
                ))
            end)

            local DropdownFunctions = {}

            function DropdownFunctions:Refresh(newOptions)
                newOptions = newOptions or {}
                selected = {}
                dropped = false
                TweenService:Create(Arrow, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Rotation = 0}):Play()
                Dropdown:TweenSize(UDim2.new(1, -6, 0, 34), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.15, true)

                for _, child in ipairs(OptionHolder:GetChildren()) do
                    if child:IsA("TextButton") then
                        child:Destroy()
                    end
                end

                for _, option in ipairs(newOptions) do
                    local Option = Instance.new("TextButton")
                    Option.Name = "Option"
                    Option.Parent = OptionHolder
                    Option.BackgroundColor3 = Colors.DarkRed
                    Option.BorderSizePixel = 0
                    Option.Size = UDim2.new(1, -16, 0, 30)
                    Option.AutoButtonColor = false
                    Option.Font = Enum.Font.Gothom
                    Option.Text = option
                    Option.TextColor3 = Colors.White
                    Option.TextSize = 14

                    local OptionCorner = Instance.new("UICorner")
                    OptionCorner.CornerRadius = UDim.new(0, 6)
                    OptionCorner.Parent = Option

                    if multiSelect then
                        local Checkmark = Instance.new("ImageLabel")
                        Checkmark.Name = "Checkmark"
                        Checkmark.Parent = Option
                        Checkmark.BackgroundTransparency = 1
                        Checkmark.Image = "rbxassetid://6031068421"
                        Checkmark.ImageTransparency = 1
                        Checkmark.Size = UDim2.new(0, 16, 0, 16)
                        Checkmark.Position = UDim2.new(0, 8, 0.5, -8)
                    end

                    Option.MouseButton1Click:Connect(function()
                        if multiSelect then
                            if selected[option] then
                                selected[option] = nil
                                Option.Checkmark.ImageTransparency = 1
                            else
                                selected[option] = true
                                Option.Checkmark.ImageTransparency = 0
                            end
                            updateTitle()
                            local selectedList = {}
                            for item, _ in pairs(selected) do
                                table.insert(selectedList, item)
                            end
                            callback(selectedList)
                        else
                            callback(option)
                            Title.Text = text .. ": " .. option
                            dropped = false
                            TweenService:Create(Arrow, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Rotation = 0}):Play()
                            Dropdown:TweenSize(UDim2.new(1, -6, 0, 34), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.15, true)
                        end
                    end)

                    Option.TouchTap:Connect(function()
                        Option.MouseButton1Click:Fire()
                    end)
                end

                OptionList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                    if dropped then
                        OptionHolder.Size = UDim2.new(1, 0, 0, OptionList.AbsoluteContentSize.Y + 15)
                    end
                end)
            end

            return DropdownFunctions
        end

        return Elements
    end

    return TabFunctions
end

return Library