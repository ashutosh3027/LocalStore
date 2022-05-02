import { Windmill } from "@windmill/react-ui";
import { CartProvider } from "context/CartContext";
import { OrderProvider } from "context/OrderContext";
import { ProductProvider } from "context/ProductContext";
import { ReviewProvider } from "context/ReviewContext";
import { UserProvider } from "context/UserContext";
import React from "react";
import ReactDOM from "react-dom";
import { HelmetProvider } from "react-helmet-async";
import App from "./App";
import reportWebVitals from "./reportWebVitals";
import "./tailwind.output.css";
import myTheme from './css/myTheme'
ReactDOM.render(
  <>
    <HelmetProvider>
      <Windmill theme={myTheme}>
            <UserProvider>
              <ProductProvider>
                <ReviewProvider>
                  <CartProvider>
                    <OrderProvider>
                      <App />
                    </OrderProvider>
                  </CartProvider>
                </ReviewProvider>
              </ProductProvider>
            </UserProvider>
      </Windmill>
    </HelmetProvider>
  </>,
  document.getElementById("root")
);
reportWebVitals();
