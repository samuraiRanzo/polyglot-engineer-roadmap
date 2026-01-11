# 🏛️ Architectural Pattern: The Service Layer
> **Knowledge Base | Backend Architecture**

## 🏗️ Core Concept
In a professional modular backend, we avoid "Fat Views" (logic in the API endpoint) and "Fat Models" (logic in the database schema). Instead, we introduce a **Service Layer** as a dedicated buffer for business logic.

---

## 🛠️ Why use this pattern?
| Layer | Responsibility | What it should NOT do |
| :--- | :--- | :--- |
| **View (API)** | Parse requests, check permissions, return HTTP codes. | Perform calculations or complex DB filters. |
| **Service** | **Execute business logic, data transformation, validation.** | Touch the Request object or handle HTTP status. |
| **Model** | Define database schema and simple properties. | Trigger external APIs or complex logic. |

---

## 💻 Implementation: `services.py`
Instead of putting logic in `views.py`, create a `services.py` file in your app folder.

### 1. The Service Function
```python
# vault/services.py
from .models import Secret
from django.core.exceptions import ValidationError

def create_user_secret(*, user, title, content) -> Secret:
    """
    Core logic for creating a secret. 
    Encapsulates validation and creation logic.
    """
    if not content:
        raise ValidationError("Secret content cannot be empty.")
        
    # Potential encryption logic goes here...
    
    secret = Secret.objects.create(
        user=user,
        title=title,
        content=content
    )
    return secret
```

### 2. The "Thin" View Usage
```python
# vault/views.py
from rest_framework.views import APIView
from rest_framework.response import Response
from .services import create_user_secret

class SecretCreateView(APIView):
    def post(self, request):
        # 1. View handles HTTP parsing & validation
        title = request.data.get('title')
        content = request.data.get('content')
        
        # 2. View calls the Service for Logic
        try:
            secret = create_user_secret(
                user=request.user, 
                title=title, 
                content=content
            )
            return Response({"id": secret.id, "status": "created"}, status=201)
        except Exception as e:
            return Response({"error": str(e)}, status=400)
```

## 🚦 Application: When to use?
In a professional modular backend, we avoid "Fat Views" (logic in the API endpoint) and "Fat Models" (logic in the database schema). Instead, we introduce a **Service Layer** as a dedicated buffer for business logic.
* **CRUD+**:When "Creating" an object involves more than just saving a row (e.g., sending an email, encrypting a field).
* **Cross-App Logic**:When one action needs to update multiple models.
* **Complex Validation**:When checking "Can this user do this?" involves more than simple permission checks.

## 💡 The "Rule of 5"
If your `views.py` function is longer than 5 lines of logic, move the logic into a Service.

---

