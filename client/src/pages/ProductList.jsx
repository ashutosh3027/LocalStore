import { Card, CardBody, Pagination } from "@windmill/react-ui";
import Product from "components/Product";
import Spinner from "components/Spinner";
import { useProduct } from "context/ProductContext";
import Layout from "layout/Layout";
import React from "react";

const ProductList = () => {
  const { products, setPage } = useProduct();

  const handleChange = (page) => {
    setPage(page);
    window.scrollTo({ behavior: "smooth", top: 0 });
  };

  if (!products) {
    return (
      <>
        <Layout>
          <Spinner size={100} loading />
        </Layout>
      </>
    );
  }

  return (
    <Layout>
      <div >
        <Card className="flex flex-wrap h-full ">
          {products.map((prod) => (
            <CardBody
              className="w-full flex flex-col justify-between sm:w-1/2 md:w-1/3 lg:w-1/4 my-2 px-2"
              key={prod.product_id}
            >
              <Product product={prod} />
            </CardBody>
          ))}
        </Card>
        <Pagination
          totalResults={20}
          resultsPerPage={12}
          onChange={handleChange}
          label="Page navigation"
        />
      </div>
    </Layout>
  );
};

export default ProductList;
