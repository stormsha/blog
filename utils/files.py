from extend.models import Attachment
import mimetypes


def upload_attachments(files, type_of):
    attachments = []
    for f in files:
        _f = Attachment.objects.create(
            file=f,
            name=f.name,
            size=f.size,
            mime_type=mimetypes.guess_type(str(f))[0],
            type_of=type_of
        )
        attachments.append(_f)
    return attachments


def upload_attachment(file, type_of='1'):
    attachment = Attachment.objects.create(
        file=file,
        name=file.name,
        size=file.size,
        mime_type=mimetypes.guess_type(str(file))[0],
        type_of=type_of
    )
    attachment.save()
    return attachment

