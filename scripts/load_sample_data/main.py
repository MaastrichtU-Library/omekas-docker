from omeka_s_tools.api import OmekaAPIClient
import config as cfg


if __name__ == "__main__":
    omeka_client = OmekaAPIClient(
        api_url=cfg.OMEKA_API_URL,
        key_identity=cfg.OMEKA_API_KEY_ID,
        key_credential=cfg.OMEKA_API_KEY
    )

    # Sample metadata dictionary for a book item
    book_item = {
        "schema:name": [
            {
                "type": "literal",
                "value": "Geometrical Solutions Derived from Mechanics. A Treatise of Archimedes"
            }
        ],
        "schema:author": [
            {
                "type": "literal",
                "value": "Archimedes"
            }
        ],
        "schema:description": [
            {
                "type": "literal",
                "value": "A scientific publication attributed to the ancient mathematician Archimedes, with a translation by Dr. J.L. Heiberg and an introduction by David Eugene Smith. This treatise, derived from manuscripts discovered in the early 20th century, belongs to the late classical era, specifically around the late Hellenistic period. The book primarily discusses the geometric principles relating to mechanics, presenting solutions that intertwine mathematical concepts with practical applications in physics. The content of the treatise elaborates on several key propositions by Archimedes, demonstrating how geometric solutions can be derived from mechanical principles. The work includes explorations of the volumes of various solid shapes such as cylinders, spheres, and parabolas, often relating their properties to practical mechanical applications. Archimedes emphasizes his innovative methods of deriving geometric proofs through intuitive and mechanical reasoning rather than purely analytical approaches. Each proposition builds upon a mechanical foundation, revealing the interconnectedness of geometry and mechanics and providing insights into Archimedes's thought process in discovering mathematical truths."
            }
        ]
    }

    # Get resource template ID
    resource_template = omeka_client.get_template_by_label('Book')
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
        template_id=5,
        class_id=None,
        item_set_id=None
    )
    print(f"New item created with ID: {new_item['o:id']}")