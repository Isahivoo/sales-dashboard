CREATE TABLE public.customers (
	customer_id varchar(50) NOT NULL,
	first_name varchar(50) NOT NULL,
	last_name varchar(50) NOT NULL,
	segment varchar(50) NOT NULL,
	location_id int4 NOT NULL,
	CONSTRAINT customers_pkey PRIMARY KEY (customer_id),
	CONSTRAINT fk_customers_locations FOREIGN KEY (location_id) REFERENCES public.locations(location_id)
);

CREATE TABLE public.locations (
	location_id int4 GENERATED ALWAYS AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1 NO CYCLE) NOT NULL,
	city varchar(50) NOT NULL,
	state varchar(50) NOT NULL,
	country varchar(50) NOT NULL,
	region varchar(50) NOT NULL,
	CONSTRAINT locations_city_state_country_region_key UNIQUE (city, state, country, region),
	CONSTRAINT locations_pkey PRIMARY KEY (location_id)
);


CREATE TABLE public.order_items (
	order_item_id int4 GENERATED ALWAYS AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1 NO CYCLE) NOT NULL,
	order_id varchar(50) NOT NULL,
	product_id int4 NOT NULL,
	order_quantity int4 NOT NULL,
	profit_per_order numeric(12, 2) NOT NULL,
	sales_per_order numeric(12, 2) NOT NULL,
	order_item_discount numeric(12, 2) NOT NULL,
	CONSTRAINT order_items_pkey PRIMARY KEY (order_item_id),
	CONSTRAINT fk_order_items_orders FOREIGN KEY (order_id) REFERENCES public.orders(order_id),
	CONSTRAINT fk_order_items_product FOREIGN KEY (product_id) REFERENCES public.products(product_id)
);

CREATE TABLE public.orders (
	order_id varchar(50) NOT NULL,
	customer_id varchar(50) NOT NULL,
	shipping_type varchar(50) NOT NULL,
	order_date date NOT NULL,
	days_for_shipment_scheduled int4 NOT NULL,
	days_for_shipment_real int4 NOT NULL,
	delivery_status varchar(50) NOT NULL,
	CONSTRAINT orders_pkey PRIMARY KEY (order_id),
	CONSTRAINT fk_orders_customers FOREIGN KEY (customer_id) REFERENCES public.customers(customer_id)
);

CREATE TABLE public.products (
	product_id int4 GENERATED ALWAYS AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1 NO CYCLE) NOT NULL,
	product_name varchar(150) NULL,
	category_name varchar(150) NULL,
	CONSTRAINT products_pkey PRIMARY KEY (product_id),
	CONSTRAINT products_product_name_category_name_key UNIQUE (product_name, category_name)
);