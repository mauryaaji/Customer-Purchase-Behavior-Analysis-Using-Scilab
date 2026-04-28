clc;
clear;
close;

// ==========================
// STEP 1: READ CSV
// ==========================
lines = mgetl("sales_data.csv");

// Show raw data
disp("RAW DATA:");
disp(lines);

// Remove header
lines(1) = [];

// ==========================
// STEP 2: PARSE DATA
// ==========================
CustomerID = [];
Product = [];
Category = [];
Amount = [];
Month = [];

for i = 1:size(lines, "*")
    row = strsplit(lines(i), ",");
    
    CustomerID(i) = evstr(row(1));
    Product(i) = stripblanks(row(2));
    Category(i) = stripblanks(row(3));
    Amount(i) = evstr(row(4));
    Month(i) = stripblanks(row(5));
end

// ==========================
// STEP 3: DISPLAY DATA
// ==========================
disp("CustomerID:");
disp(CustomerID);

disp("Product:");
disp(Product);

disp("Category:");
disp(Category);

disp("Amount:");
disp(Amount);

disp("Month:");
disp(Month);

// ==========================
// STEP 4: PRODUCT ANALYSIS
// ==========================
unique_products = unique(Product);
n = size(unique_products, "*");
product_sales = zeros(1,n);

for i = 1:n
    idx = find(Product == unique_products(i));
    product_sales(i) = sum(Amount(idx));
end

// ==========================
// GRAPH 1: PRODUCT BAR
// ==========================
scf(1); clf();
bar(product_sales);

a = gca();
a.x_ticks.locations = 1:n;
a.x_ticks.labels = unique_products;

xtitle("Product-wise Sales", "Products", "Sales");
xgrid();

// ==========================
// STEP 5: CATEGORY ANALYSIS
// ==========================
unique_category = unique(Category);
m = size(unique_category, "*");
category_sales = zeros(1,m);

for i = 1:m
    idx = find(Category == unique_category(i));
    category_sales(i) = sum(Amount(idx));
end

// ==========================
// GRAPH 2: PIE
// ==========================
scf(2); clf();
pie(category_sales);

title("Category-wise Sales");
legend(unique_category);

// ==========================
// STEP 6: MONTHLY TREND
// ==========================
months_order = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"];
monthly_sales = zeros(1,12);

for i = 1:12
    idx = find(Month == months_order(i));
    monthly_sales(i) = sum(Amount(idx));
end

// ==========================
// GRAPH 3: LINE
// ==========================
scf(3); clf();
plot(monthly_sales, '-o');

a = gca();
a.x_ticks.locations = 1:12;
a.x_ticks.labels = months_order;

xtitle("Monthly Sales Trend", "Months", "Sales");
xgrid();

// ==========================
// STEP 7: TOP 5
// ==========================
[sorted_amount, index] = gsort(Amount, "g", "i");
top5 = sorted_amount(1:5);

// ==========================
// GRAPH 4
// ==========================
scf(4); clf();
barh(top5);

xtitle("Top 5 Transactions", "Amount", "Rank");
xgrid();

// ==========================
// STEP 8: SEGMENTATION
// ==========================
high = length(find(Amount > 20000));
medium = length(find(Amount <= 20000 & Amount > 5000));
low = length(find(Amount <= 5000));

seg = [high medium low];

// ==========================
// GRAPH 5
// ==========================
scf(5); clf();
pie(seg);

title("Customer Segmentation");
legend(["High","Medium","Low"]);

// ==========================
disp("ALL IN ONE PROJECT SUCCESSFULLY RUN");
