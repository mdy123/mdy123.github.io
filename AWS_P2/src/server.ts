import fs from "fs";
import express from "express";
import bodyParser from "body-parser";
import { filterImageFromURL, deleteLocalFiles } from "./util/util";
import { fstat } from "fs";

(async () => {
  // Init the Express application
  const app = express();

  //current file name
  let currentFile: string;

  // tmp folder path
  const tmpPath: string = "./src/util/tmp";

  // Image file types
  const imgTypeList: string[] = [
    "jpg",
    "jpeg",
    "gif",
    "png",
    "tiff",
    "raw",
    "psd",
    "pdf",
    "eps",
    "al",
    "svg",
    "webp"
  ];

  // Url Regular Express
  const urlRegExp = /(ftp|http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?/;

  // Set the network port
  const port = process.env.PORT || 8082;

  // Use the body parser middleware for post requests
  app.use(bodyParser.json());

  // Root Endpoint
  // Displays a simple message to the user
  app.get("/", async (req, res) => {
    res.send("try GET /filteredimage?image_url={{}}");
  });

  // @TODO1 IMPLEMENT A RESTFUL ENDPOINT
  // GET /filteredimage?image_url={{URL}}
  // endpoint to filter an image from a public url.
  // IT SHOULD
  //    1
  //    1. validate the image_url query
  //    2. call filterImageFromURL(image_url) to filter the image
  //    3. send the resulting file in the response
  //    4. deletes any files on the server on finish of the response
  // QUERY PARAMATERS
  //    image_url: URL of a publicly accessible image
  // RETURNS
  //   the filtered image file [!!TIP res.sendFile(filteredpath); might be useful]

  /**************************************************************************** */

  //! END @TODO1

  //************************
  app.get("/filteredimage/", async (req, res) => {
    let fList: string[];
    let { image_url } = req.query;

    if (!image_url) {
      return res.status(400).send(`Image Url is required`);

    } else if (!imgTypeList.includes(image_url.split(".").pop())) {
      //Check image file extension from Image Url
      return res.status(400).send("Image Url doesn't  include image file");

    } else if (!urlRegExp.test(image_url)) {
      //Check Image Url using Regular Expression
      return res.status(400).send("Wrong Image Url ");
      
    } else {
        
      try {
        currentFile = await filterImageFromURL(image_url);
        return res.status(200).sendFile(currentFile);
      } catch (e) {
        // Check error from image processing.
        return res.status(400).send("Error in processing image.\n" + e);
      } finally {
        //Delect all the file from tmp folder except the current one.
        // if (fs.readdirSync(tmpPath).length != 0) {
        //   let listOfFile: string[] = fs
        //     .readdirSync(tmpPath)
        //     .filter(v => v != currentFile.split("/").pop());
        //   await deleteLocalFiles(listOfFile.map(v => tmpPath + "/" + v));
        // }
        console.log("Done");
      }
    }
  });

  // Start the Server
  app.listen(port, () => {
    console.log(`server running http://localhost:${port}`);
    console.log(`press CTRL+C to stop server`);
  });
})();
