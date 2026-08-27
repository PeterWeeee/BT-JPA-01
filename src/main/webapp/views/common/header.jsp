<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!-- Bootstrap 5 CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Font Awesome 6 Icons -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">

<style>
    :root {
        --primary-color: #2563eb;
        --primary-hover: #1d4ed8;
    }
    body {
        background-color: #f8fafc;
        font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;
        color: #334155;
    }
    .navbar-custom {
        background: linear-gradient(135deg, #1e293b 0%, #0f172a 100%);
        box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
    }
    .card-custom {
        border: none;
        border-radius: 1rem;
        box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.05), 0 8px 10px -6px rgba(0, 0, 0, 0.05);
        background: #ffffff;
    }
    .btn-primary-custom {
        background-color: var(--primary-color);
        border-color: var(--primary-color);
        color: #fff;
        padding: 0.6rem 1.2rem;
        border-radius: 0.5rem;
        font-weight: 500;
        transition: all 0.2s;
    }
    .btn-primary-custom:hover {
        background-color: var(--primary-hover);
        border-color: var(--primary-hover);
        color: #fff;
        transform: translateY(-1px);
    }
    .badge-role-1 { background-color: #ef4444; color: white; } /* Admin */
    .badge-role-2 { background-color: #f59e0b; color: white; } /* Manager */
    .badge-role-3 { background-color: #10b981; color: white; } /* User */
</style>
