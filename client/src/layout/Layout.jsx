import Nav from "components/Nav";
import Spinner from "components/Spinner";
import React from "react";
import { Helmet } from "react-helmet-async";
import "./../css/home.css";
import homeImg from "./../assets/bacground.png";
const Layout = ({ children, title, loading }) => {
  for (const property in children) {
    console.log(children[property]);
  }
  console.log(`title: ${title}`);
  console.log(`loading: ${loading}`);
  const myStyle = {
    backgroundImage: `url(${homeImg})`,
    height: "60vh",
    backgroundSize: "cover",
    backgroundRepeat: "no-repeat",
  };
  return (
    <>
      <Helmet>
        <meta charSet="utf-8" />
        <title>{title || "Home"} | local Store </title>
        <meta
          name="description"
          content="Ecommerce store built with React, Node, Express and Postgres"
        />
        <meta
          name="robots"
          content="max-snippet:-1, max-image-preview:large, max-video-preview:-1"
        />
        <link rel="canonical" href="https://pern-store.netlify.app/" />
        <meta property="og:locale" content="en_US" />
        <meta property="og:type" content="website" />
        <meta property="og:title" content="PERN Store" />
        <meta
          property="og:description"
          content="Ecommerce store built with React, Node, Express and Postgres"
        />
        <meta property="og:url" content="https://pern-store.netlify.app/" />
        <meta property="og:site_name" content="PERN Store" />
        <meta property="og:image" content="android-chrome-512x512.png" />
        <meta
          property="og:image:secure_url"
          content="android-chrome-512x512.png"
        />
        <meta name="twitter:card" content="summary_large_image" />
        <meta name="twitter:site" content="@_odunsi_" />
        <meta name="twitter:creator" content="@_odunsi_" />
        <meta
          name="twitter:description"
          content="Ecommerce store built with React, Node, Express and Postgres"
        />
        <meta name="twitter:title" content="PERN Store" />
        <meta name="twitter:image" content="android-chrome-512x512.png" />
        <style type="text/css">{`
        html,body{
          height: 100%;
        }
    `}</style>
      </Helmet>
      <div className="min-h-screen flex flex-col">
        <Nav />
        {loading ? (
          <>
            <Spinner size={100} loading />
          </>
        ) : (
          <div className="home-page">
            {!title? (
              <div className="py-20" style={myStyle}>
                <div className="container mx-auto my-10 px-6">
                  <h2 className="text-4xl font-bold mb-2 text-white">
                    Welcome to LocalStore!
                  </h2>
                  <h3 className="text-2xl mb-8 text-gray-200">
                    Lorem ipsum dolor sit amet consectetur adipisicing elit.
                    Velit, voluptatibus.
                  </h3>

                  <button
                    className="bg-white font-bold rounded-full py-4 px-8 shadow-lg uppercase tracking-wider group"
                    href="#product-section"
                  >
                    <a href="#product-section"> Shop Now</a>
                  </button>
                </div>
              </div>
            ):''}
            <main className="h-full" id="product-section">
              {children}
            </main>
          </div>
        )}

        {/* <footer className="mt-auto flex justify-center py-2">
          <p className="text-sm text-gray-600 sm:ml-4 sm:pl-4 sm:py-2 sm:mt-0 mt-4">
            © 2021 PERN Store —
            <a
              href="https://github.com/dhatguy"
              className="text-gray-500 ml-1"
              target="_blank"
              rel="noopener noreferrer"
            >
              @dhatGuy
            </a>
          </p>
        </footer> */}
      </div>
    </>
  );
};

export default Layout;
