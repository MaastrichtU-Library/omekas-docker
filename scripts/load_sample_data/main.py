from omeka_s_tools.api import OmekaAPIClient
import json
import config as cfg


if __name__ == "__main__":
    omeka_client = OmekaAPIClient(
        api_url=cfg.OMEKA_API_URL,
        key_identity=cfg.OMEKA_API_KEY_ID,
        key_credential=cfg.OMEKA_API_KEY
    )

    # Sample metadata dictionary for a book item
    with open("data/geometrical-solutions_metadata.json", "r", encoding="utf-8") as f:
        book_item = json.load(f)

    # Extract the system metadata and remove it from the item dictionary
    system_metadata = book_item["system_metadata"]
    book_item.pop("system_metadata", None)

    # Get resource template ID
    resource_template_label = system_metadata["resource_template"]
    resource_template = omeka_client.get_template_by_label(resource_template_label)
    resource_template_id = resource_template["o:id"]

    # Prepare an item metadata payload (dict) based on a resource template
    book_payload = omeka_client.prepare_item_payload_using_template(terms=book_item, template_id=resource_template_id)

    # Add the media file to the item metadata payload
    # TODO: remove this commented out step
    #omeka_client.add_media_to_payload(payload=book_payload, media_files=['data/geometrical-solutions.pdf'])

    # Upload the payload to Omeka and create a new item
    new_item = omeka_client.add_item(
        payload=book_payload,
        media_files=["data/geometrical-solutions.pdf"],
        template_id=resource_template_id,
        class_id=None,
        item_set_id=None
    )
    print(f"New item created with ID: {new_item['o:id']}")


    # # Sample metadata dictionary for an image item
    # with open("data/um-topstukken-books_metadata.json", "r", encoding="utf-8") as f:
    #     picture_item = json.load(f)
    #
    # # Get resource template ID
    # resource_template = omeka_client.get_template_by_label('Visual Art Works')
    # resource_template_id = resource_template["o:id"]
    #
    # # Prepare an item metadata payload (dict) based on a resource template
    # picture_payload = omeka_client.prepare_item_payload_using_template(terms=picture_item, template_id=resource_template_id)
    #
    # # Upload the payload to Omeka and create a new item
    # new_item2 = omeka_client.add_item(
    #     payload=picture_payload,
    #     media_files=["data/um-topstukken-books-1.jpg", "data/um-topstukken-books-2.jpg"],
    #     template_id=resource_template_id,
    #     class_id=None,
    #     item_set_id=None
    # )
    # print(f"New item created with ID: {new_item2['o:id']}")