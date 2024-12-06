from django.core.management.base import BaseCommand
# noinspection all
from storm.models import BigCategory


class Command(BaseCommand):
    help = 'Initialize database with sample data'

    # noinspection PyUnresolvedReferences
    def handle(self, *args, **kwargs):
        # Create sample data
        BigCategory.objects.create(field1='value1', field2='value2')
        BigCategory.objects.create(field1='value3', field2='value4')
        # Add as many objects as you need
        self.stdout.write(self.style.SUCCESS('Database initialized with sample data'))
