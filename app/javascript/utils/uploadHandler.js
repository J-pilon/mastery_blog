export function imagesUploadHandler(blob, _) {
  return new Promise(async (success, failure) => {
    const storageServiceUrl = "/uploads/storage_service";
    let file = blob;
    let storageServiceRes, presigned_url, download_url;

    if (!(file instanceof File) || !(file instanceof Blob)) {
      file = blob.blob();
    }

    try {
      storageServiceRes = await fetch(storageServiceUrl, {
        method: "GET",
      });

      if (storageServiceRes.ok === false) {
        throw `${storageServiceRes.status} - ${storageServiceRes.statusText} - while fetching the storage service URL.`;
      }
    } catch (err) {
      failure({ message: err, remove: true });
    }

    try {
      const urls = await storageServiceRes.json();
      presigned_url = urls.presigned_url;
      download_url = urls.download_url;
    } catch (err) {
      failure({ message: err, remove: true });
    }

    try {
      const uploadRes = await fetch(presigned_url, {
        method: "PUT",
        body: file,
      });

      if (!uploadRes.ok) {
        throw `${uploadRes.status} - ${uploadRes.statusText}`;
      }

      const event = new CustomEvent("imageUploadSuccess", {
        detail: { downloadUrl: download_url },
      });
      document.dispatchEvent(event);

      success(download_url);
    } catch (err) {
      failure({ message: err, remove: true });
    }
  });
}
