﻿using System.Text.RegularExpressions;
using DDDSample1.Domain.Shared;

namespace DDDNetCore.Domain.PedidosIntroducao
{
    public class EmailsPedidosIntroducao : IValueObject
    {
        public EmailsPedidosIntroducao()
        {
        }

        public EmailsPedidosIntroducao(string value)
        {
            if (!IsValidEmail(value.Trim())) throw new BusinessRuleValidationException("Email Invalido");
            Email = value;
        }

        private string Email { get; }

        public override bool Equals(object? obj)
        {
            if (this == obj) return true;

            if (obj == null || obj.GetType() != GetType()) return false;

            var that = (EmailsPedidosIntroducao) obj;

            return Email.Equals(that.Email);
        }

        public override string ToString()
        {
            return $"{Email}";
        }

        private static bool IsValidEmail(string email)
        {
            var rg = new Regex(
                @"^[A-Za-z0-9](([_\.\-]?[a-zA-Z0-9]+)*)@([A-Za-z0-9]+)(([\.\-]?[a-zA-Z0-9]+)*)\.([A-Za-z]{2,})$");

            if (rg.IsMatch(email))
                return true;
            return false;
        }
    }
}