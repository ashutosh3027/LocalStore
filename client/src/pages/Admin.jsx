import { Button, HelperText, Input, Label } from "@windmill/react-ui";
import axios from "axios";
import ForgotPasswordModal from "components/ForgotPasswordModal";
import { useUser } from "context/UserContext";
import Layout from "layout/Layout";
import React, { useState } from "react";
// import GoogleLogin from "react-google-login";
import { useForm } from "react-hook-form";
import toast from "react-hot-toast";
import { Link, Redirect, useLocation } from "react-router-dom";
import PulseLoader from "react-spinners/PulseLoader";
import authService from "services/auth.service";
import API from "api/axios.config"

const Admin = () => {
  const { isLoggedIn, setUserState } = useUser();
  const [isLoading, setIsLoading] = useState(false);
  const [redirectToReferrer, setRedirectToReferrer] = useState(false);
  const { state } = useLocation();
  const { register, handleSubmit, errors } = useForm();


  const onSubmit = async (data) => {

    const {name , price, description , image_url} = data;

    try{
        await API.post("/products", {
            name: name,
            price: price,
            description: description,
            image_url: image_url
        })
        .then((res) => {
          toast.success("Added successfully");
          console.log(res)
        })
    }
    catch(err){
        toast.failure("Only admin can add a product");  
        console.log(err)
    }

  };

  if (redirectToReferrer) {
    return <Redirect to={state?.from || "/"} />;
  }

  return (
    <Layout title="Admin">
      <div className="flex items-center justify-center m-auto mt-20">
        <form
          className="bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4 flex flex-col w-full md:w-1/2"
          onSubmit={handleSubmit(onSubmit)}
        >
          <h1 className="text-center text-4xl my-4">Add a product</h1>
          <div className="">
            <Label className="block text-grey-darker text-sm font-bold mb-2">
              <span>name</span>
            </Label>
            <Input
              className="shadow appearance-none border rounded w-full py-2 px-3 text-grey-darker"
              type="text"
              name="name"
              ref={register({ required: true })}
              placeholder="Enter a valid product name"
            />
          </div>

          <div className="mt-4">
            <Label className="block text-grey-darker text-sm font-bold mb-2">
              <span>Price</span>
            </Label>
            <input
              className="shadow appearance-none border rounded w-full py-2 px-3 text-grey-darker"
              type="int"
              name="price"
              ref={register({ required: true })}
            />
          </div>
          
          <div className="mt-4">
            <Label className="block text-grey-darker text-sm font-bold mb-2">
              <span>Description</span>
            </Label>
            <input
              className="shadow appearance-none border rounded w-full py-2 px-3 text-grey-darker"
              type="text"
              name="description"
              ref={register({ required: true })}
            />
          </div>

          <div className="mt-4">
            <Label className="block text-grey-darker text-sm font-bold mb-2">
              <span>Image Url</span>
            </Label>
            <input
              className="shadow appearance-none border rounded w-full py-2 px-3 text-grey-darker"
              type="text"
              name="image_url"
              ref={register({ required: true })}
            />
          </div>

          <Button type="submit" disabled={isLoading}>
            {isLoading ? (
              <PulseLoader color={"#0a138b"} size={10} loading={isLoading} />
            ) : (
              "Add product"
            )}
          </Button>
          
        </form>
      </div>
    </Layout>
  );
};

export default Admin;
