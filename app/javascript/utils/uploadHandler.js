export function tinymceImageUploadHandler(blob, _) {
  return new Promise(async (success, failure) => {
    const storageServiceUrl = "/uploads/storage_service";
    let file =
      blob instanceof File || blob instanceof Blob ? blob : blob.blob();

    try {
      const response = await getStorageServiceUrl(storageServiceUrl);
      const urls = await formatToJson(response);
      const { presigned_url: presignedUrl, download_url: downloadUrl } = urls;
      await uploadImage(presignedUrl, file);
      dispatchImageUploadListener(downloadUrl);

      success(
        "data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7"
      );
    } catch (err) {
      failure({ message: err, remove: true });
    }
  });
}

export function imagesUploadHandler(blob, _) {
  return new Promise(async (success, failure) => {
    const storageServiceUrl = "/uploads/storage_service";
    let file =
      blob instanceof File || blob instanceof Blob ? blob : blob.blob();

    try {
      const response = await getStorageServiceUrl(storageServiceUrl);
      const urls = await formatToJson(response);
      const { presigned_url, download_url } = urls;
      await uploadImageTo(presigned_url, file);

      success(download_url);
    } catch (err) {
      failure({ message: err, remove: true });
    }
  });
}

async function getStorageServiceUrl(url) {
  try {
    let response = await fetch(url, {
      method: "GET",
    });

    if (response.ok === false) {
      throw `${response.status} - ${response.statusText} - while fetching the storage service URL.`;
    }
    return response;
  } catch (err) {
    throw err;
  }
}

async function formatToJson(response) {
  try {
    const urls = await response.json();
    return urls;
  } catch (err) {
    throw err;
  }
}

async function uploadImage(presignedUrl, file) {
  try {
    const response = await fetch(presignedUrl, {
      method: "PUT",
      body: file,
    });

    if (!response.ok) {
      throw `${response.status} - ${response.statusText}`;
    }
    return response;
  } catch (err) {
    throw err;
  }
}

function dispatchImageUploadListener(downloadUrl) {
  const event = new CustomEvent("imageUploadSuccess", {
    detail: { downloadUrl: downloadUrl },
  });
  document.dispatchEvent(event);
}
