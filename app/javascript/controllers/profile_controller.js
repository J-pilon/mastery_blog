import { Controller } from "@hotwired/stimulus";
import { imagesUploadHandler } from "../utils/uploadHandler";

export default class extends Controller {
  static targets = ["imageInput", "imageElement", "imageUrl"];

  connect() {}

  uploadImage() {
    const file = this.imageInputTarget.files[0];
    const resp = imagesUploadHandler(file);
    resp
      .then((result) => {
        this.imageElementTarget.src = result;
        this.imageUrlTarget.value = result;
      })
      .catch((error) => {
        alert(error.message);
      });
  }
}
