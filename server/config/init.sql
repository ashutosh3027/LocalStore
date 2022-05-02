CREATE TABLE public.cart
(
    id SERIAL NOT NULL,
    user_id integer UNIQUE NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE public.cart_item
(
    id SERIAL NOT NULL,
    cart_id integer NOT NULL,
    product_id integer NOT NULL,
    quantity integer NOT NULL CHECK (quantity > 0),
    PRIMARY KEY (id),
    UNIQUE (cart_id, product_id)
);

CREATE TABLE public.order_item
(
    id SERIAL NOT NULL,
    order_id integer NOT NULL,
    product_id integer NOT NULL,
    quantity integer NOT NULL,
    PRIMARY KEY (id)
);

CREATE TYPE "payment" AS ENUM (
  'PAYSTACK',
  'STRIPE'
);

CREATE TABLE public.orders
(
    order_id SERIAL NOT NULL,
    user_id integer NOT NULL,
    status character varying(20) NOT NULL,
    date timestamp without time zone DEFAULT CURRENT_DATE NOT NULL,
    amount real,
    total integer,
    ref character varying(100),
    payment_method payment,
    PRIMARY KEY (order_id)
);

CREATE TABLE public.products
(
    product_id SERIAL NOT NULL,
    name character varying(50) NOT NULL,
    price real NOT NULL,
    description text NOT NULL,
    image_url character varying,
    PRIMARY KEY (product_id)
);

CREATE TABLE public."resetTokens"
(
    id SERIAL NOT NULL,
    email character varying NOT NULL,
    token character varying NOT NULL,
    used boolean DEFAULT false NOT NULL,
    expiration timestamp without time zone,
    PRIMARY KEY (id)
);

CREATE TABLE public.reviews
(
    user_id integer NOT NULL,
    content text NOT NULL,
    rating integer NOT NULL,
    product_id integer NOT NULL,
    date date NOT NULL,
    id integer NOT NULL,
    PRIMARY KEY (user_id, product_id)
);

CREATE TABLE public.users
(
    user_id SERIAL NOT NULL,
    password character varying(200),
    email character varying(100) UNIQUE NOT NULL,
    fullname character varying(100) NOT NULL,
    username character varying(50) UNIQUE NOT NULL,
    google_id character varying(100) UNIQUE,
    roles character varying(10)[] DEFAULT '{customer}'::character varying[] NOT NULL,
    address character varying(200),
    city character varying(100),
    state character varying(100),
    country character varying(100),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id)
);

ALTER TABLE public.cart
    ADD FOREIGN KEY (user_id)
    REFERENCES public.users (user_id)
    ON DELETE SET NULL
    NOT VALID;


ALTER TABLE public.cart_item
    ADD FOREIGN KEY (cart_id)
    REFERENCES public.cart (id)
    ON DELETE CASCADE
    NOT VALID;


ALTER TABLE public.cart_item
    ADD FOREIGN KEY (product_id)
    REFERENCES public.products (product_id)
    ON DELETE SET NULL
    NOT VALID;


ALTER TABLE public.order_item
    ADD FOREIGN KEY (order_id)
    REFERENCES public.orders (order_id)
    ON DELETE CASCADE
    NOT VALID;


ALTER TABLE public.order_item
    ADD FOREIGN KEY (product_id)
    REFERENCES public.products (product_id)
    ON DELETE SET NULL
    NOT VALID;


ALTER TABLE public.orders
    ADD FOREIGN KEY (user_id)
    REFERENCES public.users (user_id)
    ON DELETE CASCADE
    NOT VALID;


ALTER TABLE public.reviews
    ADD FOREIGN KEY (product_id)
    REFERENCES public.products (product_id)
    ON DELETE SET NULL
    NOT VALID;


ALTER TABLE public.reviews
    ADD FOREIGN KEY (user_id)
    REFERENCES public.users (user_id)
    ON DELETE SET NULL
    NOT VALID;

CREATE UNIQUE INDEX users_unique_lower_email_idx
    ON public.users (lower(email));

CREATE UNIQUE INDEX users_unique_lower_username_idx
    ON public.users (lower(username));

INSERT INTO public.products (product_id, name, price, description, image_url) VALUES (1, 'SOAP', 10, ' a cleansing and emulsifying agent made usually by action of alkali on fat or fatty acids and consisting essentially of sodium or potassium salts of such acids.', 'https://i.ibb.co/R3V70V4/kindpng-147324.png');
INSERT INTO public.products (product_id, name, price, description, image_url) VALUES (2, 'TOOTHBRUSH', 20, 'A toothbrush is an oral hygiene tool used to clean the teeth, gums, and tongue.', 'https://i.ibb.co/8c0CYCD/toppng-com-toothbrush-and-toothpaste-8000x4113.png');
INSERT INTO public.products (product_id, name, price, description, image_url) VALUES (12, 'CHOCOLATES', 21, 'Chocolate is a food made from cacao beans. It is used in many desserts like pudding, cakes, candy, ice cream, and Easter eggs. ', 'https://i.ibb.co/T0z80W3/pngegg.png');
INSERT INTO public.products (product_id, name, price, description, image_url) VALUES (3, 'BISCUITS', 30, 'biscuit, in the United States, a small quick bread usually made from flour, salt, and butter or vegetable shortening, with baking powder as a leavening agent.', 'https://i.ibb.co/VNk41LG/580b57fbd9996e24bc43c0f4.png');
INSERT INTO public.products (product_id, name, price, description, image_url) VALUES (5, 'FACEWASH',30.5 , 'Face wash is a gentle liquid soap that gives deep pore cleansing. It is an easiest way to get rid of the extra oil, makeup and dust particles from the skin.', 'https://i.ibb.co/mz3GqSd/pngegg-1.png');
INSERT INTO public.products (product_id, name, price, description, image_url) VALUES (9, 'CUSTARD APPLE', 60, 'Custard apples have delicious mellow flesh that is almost as soft as custard. Custard apples are thought to have originated in South America and the West Indies. These apples are usually heart or oval in shape and can weigh up to 450g. They have quilted skin that is light tan or greenish in color and turns brown as the fruit ripens.', 'https://i.ibb.co/ctRZSqC/sugar-apple-custard-apple-sharifa-1.jpg');
INSERT INTO public.products (product_id, name, price, description, image_url) VALUES (4, 'MAGGI', 180, 'Maggi noodles are dried noodles fused with oil, and sold with a packet of flavorings.', 'https://i.ibb.co/3My4Q56/Nice-Png-garnish-png-3113866.png');
INSERT INTO public.products (product_id, name, price, description, image_url) VALUES (6, 'WASHING POWDER', 80, ' soap in the form of a powder that is used to wash clothes, towels, sheets, etc.', 'https://i.ibb.co/64JtDqc/Nice-Png-shree-png-2629701.png');
INSERT INTO public.products (product_id, name, price, description, image_url) VALUES (7, 'SUGAR', 700, 'sugar, any of numerous sweet, colourless, water-soluble compounds present in the sap of seed plants and the milk of mammals and making up the simplest group of carbohydrates', 'https://i.ibb.co/bXksBM6/Sugar-34683.png');
INSERT INTO public.products (product_id, name, price, description, image_url) VALUES (8, 'SPROUTS', 50, 'Sprouting is the natural process by which seeds or spores germinate and put out shoots, and already established plants produce new leaves or buds, or other structures experience further growth.', 'https://i.ibb.co/CP9gMyn/Nice-Png-cereal-png-1489010.png');
INSERT INTO public.products (product_id, name, price, description, image_url) VALUES (10, 'SALT PACKET', 55,'Salt packets typically have about 0.75 gram of salt each, which is equivalent to two dashes of salt. While that might not sound like a lot, salt is made up of 40 percent sodium, the American Heart Association explains. So that one tiny packet adds over 300 milligrams of sodium to your dish.', 'https://i.ibb.co/dtFQWD0/pngkit-tiranga-png-371207.png');
INSERT INTO public.products (product_id, name, price, description, image_url) VALUES (11, 'BREAD', 22, 'Bread, baked food product made of flour or meal that is moistened, kneaded, and sometimes fermented. A major food since prehistoric times, it has been made in various forms using a variety of ingredients and methods throughout the world.', 'https://i.ibb.co/1rWgGBM/Nice-Png-bread-loaf-png-10108516.png');
INSERT INTO public.products (product_id, name, price, description, image_url) VALUES (13, 'GINGER', 15, 'Ginger is the dried knobby shaped rhizome of the plant Zingiber officinale. ', 'https://i.ibb.co/D8LD5rg/Nice-Png-ginger-png-933932.png');
INSERT INTO public.products (product_id, name, price, description, image_url) VALUES (14, 'OATS', 90, 'Oats are a gluten-free whole grain and a great source of important vitamins, minerals, fiber, and antioxidants.','https://i.ibb.co/G2GpKbc/Nice-Png-bowl-of-cereal-png-710058.png');
INSERT INTO public.products (product_id, name, price, description, image_url) VALUES (15, 'TEA', 6, 'Tea is an aromatic beverage prepared by pouring hot or boiling water over cured or fresh leaves of Camellia sinensis, an evergreen shrub native to China, India and other East Asian countries.', 'https://i.ibb.co/80FGCPR/Nice-Png-lipton-logo-png-4679691.png');
INSERT INTO public.products (product_id, name, price, description, image_url) VALUES (16, 'ICECREAM - DARK SUPER CONE', 70, 'Natural flavors, colors, and fragrances Contains no peanuts or nuts. 4 cones of French Vanilla ice cream and 4 cones of Dark Chocolate ice cream with a thick dark chocolate core These Super Cones are made with 100% Canadian dairy and are wrapped in dark chocolate sugar cones with a chocolate topping. A fantastic flavor offering in a great family package.
Delectables for a single serving
Produced in a peanut and nut-free environment.', 'https://i.ibb.co/KXqcnsG/icecream.png');
INSERT INTO public.products (product_id, name, price, description, image_url) VALUES (17, 'BANANA', 12, 'A banana is a curved, yellow fruit with a thick skin and soft sweet flesh.', 'https://i.ibb.co/SNZStL6/Nice-Png-banana-png-238527.png');
INSERT INTO public.products (product_id, name, price, description, image_url) VALUES (18, 'APPLE', 100, ' The apple is a pome (fleshy) fruit, in which the ripened ovary and surrounding tissue both become fleshy and edible.','https://i.ibb.co/Vw5xzJ8/Nice-Png-apple-png-118739.png');
INSERT INTO public.products (product_id, name, price, description, image_url) VALUES (19, 'CASHEW', 35, 'Cashew nut is made up of a fruit in which the kernel is embedded. The real fruit of the cashew is commonly a nut. It is a kidney- or heart-shaped achene, in any normal variety. Its color varies from bottle green to grayish brown (dried fruit).', 'https://i.ibb.co/DMG4XwJ/Nice-Png-cashew-png-658199.png');
INSERT INTO public.products (product_id, name, price, description, image_url) VALUES (20, 'BADAM', 65, ' They lower LDL (bad) cholesterol and are packed with vitamin E, magnesium and potassium, which helps oxygen and nutrients flow more freely through the blood. ', 'https://i.ibb.co/WDHKdP4/Nice-Png-almond-png-2173912.png');